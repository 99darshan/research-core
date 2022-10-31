import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:researchcore/models/core_api_response.dart';
import 'package:researchcore/utils/config_util.dart';

class CoreApiClient {
  static const limit = 50;

  static Future<CoreApiResponse> fetchArticles(String searchText,
      {int? minYear, int? maxYear, int? offset}) async {
    try {
      const queryUrl = 'https://api.core.ac.uk/v3/search/works';
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer ${ConfigUtil.rotateAuthKey()}', // for local development put your own key,
        HttpHeaders.userAgentHeader: 'PostmanRuntime/7.29.0'
      };

      final payload = {
        'q': '$searchText AND year>=$minYear AND year<=$maxYear',
        'limit': limit,
        'offset': offset,
        'stats': false,
        'raw_stats': false,
        'exclude': ['fullText']
      };

      final response = await Dio().post(
        queryUrl,
        options: Options(headers: headers),
        data: jsonEncode(payload),
      );

      print('fetching data... ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return CoreApiResponse.fromJson(response.data);
      } else {
        // catch rate limit status code and show appropriate error message on the widget TODO:
        throw Exception(
            'Non 200 Status Code ${response.statusCode.toString()}');
      }
    } on Exception catch (e) {
      // catch no internet exception and show appropriate error message TODO:
      throw Exception("Error fetching data from the API");
    }
  }

  static Future<CoreApiResponse> sendMockRequest() async {
    // change this to false to mock errors
    if (true) {
      return CoreApiResponse.fromJson(mockResponseData());
    } else {
      // mock error
      throw Exception('Error Fetching Data from the API!');
    }
  }

  static mockResponseData() {
    return {
      "totalHits": 23027,
      "limit": 5,
      "offset": 0,
      "scrollId": null,
      "results": [
        {
          "acceptedDate": "2006-07-25T00:00:00",
          "arxivId": "1010.1833",
          "authors": [
            {"name": "Andrea Piccolroaz"},
            {"name": "Bertoldi"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Bigoni"},
            {"name": "Davide Bigoni"},
            {"name": "John R. Willis"},
            {"name": "Lebedev"},
            {"name": "Loret"},
            {"name": "Rice"},
            {"name": "Willis"}
          ],
          "citationCount": null,
          "contributors": [""],
          "outputs": [
            "https://api.core.ac.uk/v3/outputs/2151540",
            "https://api.core.ac.uk/v3/outputs/237725297"
          ],
          "createdDate": "2012-04-13T14:18:19",
          "dataProviders": [
            {
              "id": 144,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/144",
              "logo": "https://api.core.ac.uk/data-providers/144/logo"
            },
            {
              "id": 4786,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/4786",
              "logo": "https://api.core.ac.uk/data-providers/4786/logo"
            }
          ],
          "depositedDate": "2006-11-01T00:00:00",
          "abstract":
              "Flutter instability in an infinite medium is a form of material instability\ncorresponding to the occurrence of complex conjugate squares of the\nacceleration wave velocities. Although its occurrence is known to be possible\nin elastoplastic materials with nonassociative flow law and to correspond to\nsome dynamically growing disturbance, its mechanical meaning has to date still\neluded a precise interpretation. This is provided here by constructing the\ninfinite-body, time-harmonic Green's function for the loading branch of an\nelastoplastic material in flutter conditions. Used as a perturbation, it\nreveals that flutter corresponds to a spatially blowing-up disturbance,\nexhibiting well-defined directional properties, determined by the wave\ndirections for which the eigenvalues become complex conjugate. Flutter is shown\nto be connected to the formation of localized deformations, a dynamical\nphenomenon sharing geometrical similarities with the well-known mechanism of\nshear banding occurring under quasi-static loading. Flutter may occur much\nearlier than shear banding in a process of continued plastic deformation.Comment: 32 pages, 12 figure",
          "documentType": "research",
          "doi": "10.1016/j.jmps.2006.05.005",
          "downloadUrl": "http://arxiv.org/abs/1010.1833",
          "fieldOfStudy": null,
          "id": 722934,
          "identifiers": [
            {"identifier": "2001901553", "type": "MAG_ID"},
            {"identifier": "237725297", "type": "CORE_ID"},
            {"identifier": "oai:arxiv.org:1010.1833", "type": "OAI_ID"},
            {"identifier": "2151540", "type": "CORE_ID"},
            {"identifier": "10.1016/j.jmps.2006.05.005", "type": "DOI"},
            {"identifier": "1010.1833", "type": "ARXIV_ID"}
          ],
          "title":
              "A dynamical interpretation of flutter instability in a continuous medium",
          "language": {"code": "en", "name": "English"},
          "magId": null,
          "oaiIds": ["oai:arxiv.org:1010.1833"],
          "publishedDate": "2010-10-09T00:00:00",
          "publisher": "'Elsevier BV'",
          "pubmedId": null,
          "references": [],
          "sourceFulltextUrls": ["http://arxiv.org/abs/1010.1833"],
          "updatedDate": "2021-03-31T06:15:42",
          "yearPublished": 2010,
          "journals": [
            {
              "title": null,
              "identifiers": ["0022-5096"]
            }
          ],
          "links": [
            {"type": "download", "url": "http://arxiv.org/abs/1010.1833"},
            {"type": "display", "url": "https://core.ac.uk/works/722934"}
          ]
        },
        {
          "acceptedDate": null,
          "arxivId": "1312.4233",
          "authors": [
            {"name": "Carrera, E"},
            {"name": "Ferreira, AJM"},
            {"name": "Manickam, G"},
            {"name": "Natarajan, S"}
          ],
          "citationCount": null,
          "contributors": [],
          "outputs": ["https://api.core.ac.uk/v3/outputs/24987673"],
          "createdDate": "2014-10-24T19:23:06",
          "dataProviders": [
            {
              "id": 144,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/144",
              "logo": "https://api.core.ac.uk/data-providers/144/logo"
            }
          ],
          "depositedDate": null,
          "abstract":
              "In this paper, the linear flutter characteristics of laminated composite flat\npanels immersed in a supersonic flow is investigated using field consistent\nelements within the framework of unified formulation. The influence of the\naerodynamic damping on the supersonic flutter characteristics of flat composite\npanels is also investigated. The aerodynamic force is evaluated using\ntwo-dimensional static aerodynamic approximation for high supersonic flow.\nNumerical results are presented for laminated composites that bring out the\ninfluence of the flow angle, the boundary conditions, the plate thickness and\nthe plate aspect ratio on the flutter characteristics",
          "documentType": "research",
          "doi": null,
          "downloadUrl": "https://core.ac.uk/download/143956574.pdf",
          "fieldOfStudy": null,
          "id": 17167962,
          "identifiers": [
            {"identifier": "1312.4233", "type": "ARXIV_ID"},
            {"identifier": "oai:arxiv.org:1312.4233", "type": "OAI_ID"},
            {"identifier": "24987673", "type": "CORE_ID"}
          ],
          "title":
              "Supersonic flutter analysis of flat composite panels by unified\n  formulation",
          "language": {"code": "en", "name": "English"},
          "magId": null,
          "oaiIds": ["oai:arxiv.org:1312.4233"],
          "publishedDate": "2013-12-15T00:00:00",
          "publisher": "",
          "pubmedId": null,
          "references": [],
          "sourceFulltextUrls": ["http://arxiv.org/abs/1312.4233"],
          "updatedDate": "2020-12-24T13:22:50",
          "yearPublished": 2013,
          "journals": [],
          "links": [
            {"type": "download", "url": "http://arxiv.org/abs/1312.4233"},
            {"type": "display", "url": "https://core.ac.uk/works/17167962"}
          ]
        },
        {
          "acceptedDate": null,
          "arxivId": "1509.06726",
          "authors": [
            {"name": "Alben, Silas"},
            {"name": "Li, Chenyang"},
            {"name": "Wang, Xiaolin"},
            {"name": "Young, Yin Lu"}
          ],
          "citationCount": null,
          "contributors": [],
          "outputs": ["https://api.core.ac.uk/v3/outputs/42638411"],
          "createdDate": "2016-08-03T02:21:20",
          "dataProviders": [
            {
              "id": 144,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/144",
              "logo": "https://api.core.ac.uk/data-providers/144/logo"
            }
          ],
          "depositedDate": null,
          "abstract":
              "We investigate the effect of piezoelectric (PZT) material on the flutter\nspeed, vibration mode and frequency, and energy harvesting power and efficiency\nof a flexible flag in various fluids. We develop a fully coupled\nfluid-solid-electric model by combining the inviscid vortex sheet model with a\nlinear electro-mechanical coupling model. A resistance only circuit and a\nresonant resistance-inductance (RL) circuit are considered. For a purely\nresistive circuit, an increased electro-mechanical coupling factor results in\nan increased flutter speed, vibration frequency, averaged electric power and\nefficiency. A consistent optimal resistance is found that maximizes the flutter\nspeed and the energy harvesting power. For a resonant RL circuit, by tuning the\ninductance to match the circuit frequency to the flag's vibration frequency,\nthe flutter speed can be greatly decreased, and a larger averaged power and\nefficiency are obtained. We also consider a model scale set-up with several\ncommonly used commercial materials for operating in air and water. Typical\nranges of dimensionless parameters are obtained for four types of material that\nspan a wide range of solid density and rigidity values. We find that the\nresistance only circuit is more effective when the flag is placed in a lighter\nfluid (e.g. air), while the RL circuit is able to reduce the flutter speed when\nthe flag is placed in a heavier fluid (e.g. water)",
          "documentType": "research",
          "doi": "10.1063/1.4940990",
          "downloadUrl": "http://arxiv.org/abs/1509.06726",
          "fieldOfStudy": null,
          "id": 24732269,
          "identifiers": [
            {"identifier": "oai:arxiv.org:1509.06726", "type": "OAI_ID"},
            {"identifier": "1509.06726", "type": "ARXIV_ID"},
            {"identifier": "42638411", "type": "CORE_ID"},
            {"identifier": "10.1063/1.4940990", "type": "DOI"}
          ],
          "title": "Stability and scalability of piezoelectric flags",
          "language": {"code": "en", "name": "English"},
          "magId": null,
          "oaiIds": ["oai:arxiv.org:1509.06726"],
          "publishedDate": "2015-09-22T01:00:00",
          "publisher": "'AIP Publishing'",
          "pubmedId": null,
          "references": [],
          "sourceFulltextUrls": ["http://arxiv.org/abs/1509.06726"],
          "updatedDate": "2020-12-24T13:48:50",
          "yearPublished": 2015,
          "journals": [],
          "links": [
            {"type": "download", "url": "http://arxiv.org/abs/1509.06726"},
            {"type": "display", "url": "https://core.ac.uk/works/24732269"}
          ]
        },
        {
          "acceptedDate": null,
          "arxivId": "1903.03298",
          "authors": [
            {"name": "Colonius, Tim"},
            {"name": "Tosi, Luis Phillipe"}
          ],
          "citationCount": null,
          "contributors": [],
          "outputs": ["https://api.core.ac.uk/v3/outputs/200809410"],
          "createdDate": "2019-06-02T01:58:58",
          "dataProviders": [
            {
              "id": 144,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/144",
              "logo": "https://api.core.ac.uk/data-providers/144/logo"
            }
          ],
          "depositedDate": null,
          "abstract":
              "Characterizing the dynamics of a cantilever in channel flow is relevant to\napplications ranging from snoring to energy harvesting. Aeroelastic flutter\ninduces large oscillating amplitudes and sharp changes with frequency that\nimpact the operation of these systems. The fluid-structure mechanisms that\ndrive flutter can vary as the system parameters change, with the stability\nboundary becoming especially sensitive to the channel height and Reynolds\nnumber, especially when either or both are small. In this paper, we develop a\ncoupled fluid-structure model for viscous, two-dimensional channel flow of\narbitrary shape. Its flutter boundary is then compared to results of\ntwo-dimensional direct numerical simulations to explore the model's validity.\nProvided the non-dimensional channel height remains small, the analysis shows\nthat the model is not only able to replicate DNS results within the parametric\nlimits that ensure the underlying assumptions are met, but also over a wider\nrange of Reynolds numbers and fluid-structure mass ratios. Model predictions\nalso converge toward an inviscid model for the same geometry as Reynolds number\nincreases",
          "documentType": "research",
          "doi": null,
          // "downloadUrl": "http://arxiv.org/abs/1903.03298",
          "fieldOfStudy": null,
          "id": 58957471,
          "identifiers": [
            {"identifier": "1903.03298", "type": "ARXIV_ID"},
            {"identifier": "oai:arxiv.org:1903.03298", "type": "OAI_ID"},
            {"identifier": "200809410", "type": "CORE_ID"}
          ],
          "title":
              "Modeling and Simulation of a Fluttering Cantilever in Channel Flow",
          "language": {"code": "en", "name": "English"},
          "magId": null,
          "oaiIds": ["oai:arxiv.org:1903.03298"],
          "publishedDate": "2019-03-08T00:00:00",
          "publisher": "",
          "pubmedId": null,
          "references": [],
          "sourceFulltextUrls": ["http://arxiv.org/abs/1903.03298"],
          "updatedDate": "2020-12-24T14:48:23",
          "yearPublished": 2019,
          "journals": [],
          "links": [
            {"type": "download", "url": "http://arxiv.org/abs/1903.03298"},
            {"type": "display", "url": "https://core.ac.uk/works/58957471"}
          ]
        },
        {
          "acceptedDate": null,
          "arxivId": "1708.06987",
          "authors": [
            {"name": "Gutschmidt, Stefanie"},
            {"name": "Pons, Arion"}
          ],
          "citationCount": null,
          "contributors": [],
          "outputs": ["https://api.core.ac.uk/v3/outputs/93938051"],
          "createdDate": "2017-10-17T02:37:30",
          "dataProviders": [
            {
              "id": 144,
              "name": "",
              "url": "https://api.core.ac.uk/v3/data-providers/144",
              "logo": "https://api.core.ac.uk/data-providers/144/logo"
            }
          ],
          "depositedDate": null,
          "abstract":
              "This paper presents a novel application of multiparameter spectral theory to\nthe study of structural stability, with particular emphasis on aeroelastic\nflutter. Methods of multiparameter analysis allow the development of new\nsolution algorithms for aeroelastic flutter problems; most significantly, a\ndirect solver for polynomial problems of arbitrary order and size, something\nwhich has not before been achieved. Two major variants of this direct solver\nare presented, and their computational characteristics are compared. Both are\neffective for smaller problems arising in reduced-order modelling and\npreliminary design optimization. Extensions and improvements to this new\nconceptual framework and solution method are then discussed.Comment: 20 pages, 8 figure",
          "documentType": "research",
          "doi": "10.1115/1.4039671",
          "downloadUrl": "http://arxiv.org/abs/1708.06987",
          "fieldOfStudy": null,
          "id": 44593094,
          "identifiers": [
            {"identifier": "oai:arxiv.org:1708.06987", "type": "OAI_ID"},
            {"identifier": "1708.06987", "type": "ARXIV_ID"},
            {"identifier": "93938051", "type": "CORE_ID"},
            {"identifier": "10.1115/1.4039671", "type": "DOI"}
          ],
          "title":
              "Multiparameter spectral analysis for aeroelastic instability problems",
          "language": {"code": "en", "name": "English"},
          "magId": null,
          "oaiIds": ["oai:arxiv.org:1708.06987"],
          "publishedDate": "2017-08-20T01:00:00",
          "publisher": "'ASME International'",
          "pubmedId": null,
          "references": [],
          "sourceFulltextUrls": ["http://arxiv.org/abs/1708.06987"],
          "updatedDate": "2020-12-24T14:18:08",
          "yearPublished": 2017,
          "journals": [],
          "links": [
            {"type": "download", "url": "http://arxiv.org/abs/1708.06987"},
            {"type": "display", "url": "https://core.ac.uk/works/44593094"}
          ]
        }
      ],
      "tooks": null,
      "esTook": null
    };
  }
}
