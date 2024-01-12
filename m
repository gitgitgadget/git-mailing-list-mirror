Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2044.outbound.protection.outlook.com [40.92.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB35B5AF
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="su6z8SKp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIDWUeF0NcjRgPesx7jckjsMovrrl5/B2KehRoRErLuJ/Y3zIqCA8LFrtNRlmFQ2JC3bkAyPi0lRXCefcWTBR7aWBa2Ks6py3a8eGjs9uo3vbumUnx1GjLQqFn3tN14IG+TfzGKyCQsNPbJF9AvVfHpMHp023CnL9mittCO72Z9GBcGOK0mDsVjUIb9xFdnIxmqVNAjR5hJ4v3BJVdPfnCqE01TOpHM1KhfC6QKjbi3WE+jjXRQixHg8N1QxzvIuGowyujIaXE54KzRQKmdANRNSp8ySDd5J8nIbbkJP2vBDuG1OW66+3kvlrnXHKDySZTYGUDtV2RIuIOdhEZ/bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jar88T+r0S8HJ8UJ/oDViFsaEIOJzQb8jxwWL8wZNPY=;
 b=XuKVq0JxGS6fwD849h9xT0yLiBeYWYkrNQHUxxNut1uGgooyPLDKqG7TTtdsXCzpwYBnsSLkrnJz1Su9ohMiFA5Gy8HrlhtbCmBbVlZ/GjNvnbFD191FCZWV6oWLHA36j65S+MlpZk/El4wfFutIgTRLGk38v8ftfZDx1Gv0eKuiz9tJ1CHEnSt2RISzUFL+dYTVSfwsta+8YKBSKAlTHUo4qXjPDmhbRcezxZH6hcNw/Gzqmd/o1Qzm8dcus86/PYCgEJ2a/Xoavc7E29VH+G6xCotqTo9EypA98SvHSr/wvrZcrT1ET1a8Z/xVgNTBep2p5ufEf+7+oYYvDnL0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jar88T+r0S8HJ8UJ/oDViFsaEIOJzQb8jxwWL8wZNPY=;
 b=su6z8SKp6m+Gr+71rGkoUfQ6At4pyfFYyPkQzgCQYcsq7PXTvYnnTPEZDUUARh2Go9EKZaSUgxYIVzCtCkdP7oN4ed31uOAcG4J6pv9ScQVJ7pGVUKmYTxlRgRS+NnHvqD+AZLWWTWEd+9uR1zWkgF0K3JkloOyX33Lz9qCNWwphArCPm8eQ2w2lxJ2Aogoz6h+BeQ/g1HxXOn75z9c9ZEpRZoiUmGUAvMZ59+suJ4bz7/oXdfdk1zP3kqn65ZOvQOZS55KgcOIr+tPPk7CmsgonubaD7sVg504B49As0AJycOCmW+/E542r7ZkSIyU+RH5L7lmKKb+pLPZDSTcnvA==
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d9::7)
 by DM3P220MB1690.NAMP220.PROD.OUTLOOK.COM (2603:10b6:0:42::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.24; Fri, 12 Jan 2024 05:25:24 +0000
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9]) by LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 05:25:24 +0000
From: ross nicholas Oneil thomas <rossrecovery93245@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Hello can you join me on slack
Thread-Topic: Hello can you join me on slack
Thread-Index: AQHaRRe9EV2x4ej3DkeSXASNtleLaA==
Date: Fri, 12 Jan 2024 05:25:23 +0000
Message-ID:
 <LV3P220MB1286C5C0894337A5D36C001DFB6F2@LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [bCEXXhuLhKNe1w+GDzLHErHB+yzLPsy/bcbZlWg22AI=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3P220MB1286:EE_|DM3P220MB1690:EE_
x-ms-office365-filtering-correlation-id: ad38c123-90e7-4fb8-8045-08dc132ee079
x-ms-exchange-slblob-mailprops:
 WcKQPEuhm/v+UI7VT9ynRk6JGOWCRRu4ZKI7hKji9+icPqtcqbQ8fNL1TWeutbEWfL6/YX/Snk/RSaVys5ePHfSkp0aeNt6atJ99HlRpJvFF0fLoN1fnvMjcppatNyNAEZGIrwfG7q4K83sUxXcvX1ZDfeK8VLTbc+7zy3oHGz3h4V0H+XcxGFRpPvQbyHfItSjJpeeo9KWnczSY6AJTB2XGWRQgZ7zRZUMOi+D0W7fqNgj6K07Tx2NYzQ2L+qmYhlDckQKOsS8Qu2C5xBEs2ysLTXTK4YkJ2579SKbcHy/POA5/FeSHLTwSDishZvnhdBScPGmrEbBNbROOVMzCZkwrDF3PTLX09e196tSuUF9PjMBUzkdZ/qltoMjL1m0p5rfJxV1XfNb5kZgESrRty83fBrJejzip/r8jcsk4X2MD+suAz7oP/RH0DaEAAqUGuApMYMqIsiz5gEMuqIw9pJYs0IGB1tFt/WG1GR9YHRf/aMPPqu2yc/36gZeXwcSgKP7iLxDXCOKZ6FOtv+Kt87EeKguJm04U7CGsYUVM7PMYSmlcMQuF7iogvbjDrk0FCFZe1MNSiHvSq4+WdxNxjJNnpv0ZXHINx8x6fjGHk6Ns24igkTPpflEUtjUe1MY7DHhcDGJx77wv31M2/xCTT9yPslpDl1/raNZ/5jmtXxUlAyJxsNg1XXnS1CqQ2l1q1Di7Ui5muay6CEP3s8LPlbegCTu/r3++zcmRhQlHVkL5Tr4M4uezSGWqmt6hG0qmfsUXv5YeyUvVdtGSViZ2F7YoaiVIVs6ueECrXnO7de9V+MtDlPFhsLVTFYxsuQ2kJklUbzRbFvwl6evVogRHk+XOotYNynF3ZB3NfBdSSmc=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xr6JyUQP0Chp0okw5UbQvlf8vsk1BunTKpIeMAhXm9WRGL2KCKz2sDJN3jnij/qTs7o8CR4anTyFBH/epVLqRpEQImbSuBOIt8EYjnFNHxwpU8X4ru9JIo28Nt8gh8oL5/08zmakUxchRPLdTb1WOQk4P7szMmEY59SsSQBmDJ5vAiIn8gs2xK9qud0rX4bOxULsPnzcqUBWtYQmwdW9InZ2MFJ4mUGyUvABH7uPimIJ35OcJ6iQ18r5CXzaEbOuTskADRZnXXj/DQDzFXX8c/QgGWh8zDsk5vrcHTpAc7/9ZKBxphfYAI00gVnBAfoA7xxSqhRJ6qQx0vvM8vSVpFCoerMtkY2RG8cZsezmwrilnv/uuDXxQB8RfYJp9dhbJv9gBXSXv3pDLyd+hoY4D6ws1/t70ITE9vi523mJViqpCXjKX+dySB7x0p7fNAv9uxgWicqFdIy18Ar7TIOd45ztBpy65ChrJoDuWHSSEY2Qnx+6yTDGnPcLpr+pmBjmCyvrYQ5ju4/RXbVAjT+HMtmK2LGjN1eldIgmHjsY6m302+AlFyISp/wOGLScBcmhRflUEuvAfq+719qIRpt2IOjtPok+B0NY7lXSmfk+PAaPb1pRorMxH9FQNpMIQfgCr62yeynvh+wOjHzwNwJJlA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y9wkgiuEBTxyMkkbRcwby6zd06A0iRCpEy6lERaUolQLHVycwV0B/mgqJe9e?=
 =?us-ascii?Q?J67Qv9BCiO/XzaUoRAwVqBBcEEhditnNXv2mXGSQL5hIMG24D6mseR+CfexU?=
 =?us-ascii?Q?cmbqJBsyw8tfK7Be5afNoVevHikUV2pxbYCSrOx5bASGv/YtWwEtQ0SGjZX4?=
 =?us-ascii?Q?VwmkKMEICVVFjzcEzwaFH5Rsd/xKrAx2nX6dugh3tM5Sf6oz21A6t0pSn9Ep?=
 =?us-ascii?Q?gGL3AO3E4XLkFQj0nl1Gb7iuOc3Mi/uhZsc3Ln/D7OTJL6eDu2jppe141mkY?=
 =?us-ascii?Q?E8y1djz188g2v7CYheoIh1EgARB5FDu9Kf4Tofrh7QCn7EJ4RhY1Au+amNMJ?=
 =?us-ascii?Q?3/kNLry4f2jjUcg1tg0HXoaji60YMEkeUb35nFAzLFjc04VmTYHgUyZtMUbi?=
 =?us-ascii?Q?7JNdHvetqPSbKXyQvLjmeNVa0KXCxfUUnbBPCT2EZ0QafI+IpXGOnAhWNOV0?=
 =?us-ascii?Q?gvjiVLsTnsEuIg0G9pZ+brZUlPYquCP8I1fmr7ecUlOgyG5+Ov+X50JychZ9?=
 =?us-ascii?Q?1kck9UaXlQqQRjeqc+23BO0rO1YNT1yIeHLPpDlM8KcWSMQ3J5w0Pk2DI5cG?=
 =?us-ascii?Q?Ry1vT9ZGxarS9+KWtIdRrUHWnF/meJBovFVKm1e/huQO/25eP6TeBo+CtVjT?=
 =?us-ascii?Q?6rbhkFm53ivY/zHuOT7faQ9bhdN3xhLwjA38BrJTGxhrgiPy5T7cSF5t3v/d?=
 =?us-ascii?Q?g6gq8rSoHaP1LvR8TcHNFZfbEN1Xg2Afnyl/Bbwotdwl5EOcEwvZu7DdHWEY?=
 =?us-ascii?Q?5/1nTVwbnOyGp/x6hmwudJoDmxaPb0yXWddXr6cl/rp6RdEOe6V9lyHLE63w?=
 =?us-ascii?Q?X0q/S3GTVDUtGEzQLj8WXToeUBC720tG2gYYv7/On/Kt95H3EJ31fW0ZEegv?=
 =?us-ascii?Q?mvGcNb8lxZl/LBbd7He1ubDMVwVRJ2jJ5bAmztuYNbbdIpnbB6jmD5dfvQlM?=
 =?us-ascii?Q?6EYzUE2biRZYiXRHV0e044OhVGW0evqT3L5P6R4ghOqU3FPBrhuV00FAJs04?=
 =?us-ascii?Q?OWfdBE1uQEli8TIcSkPEMu1QtAxXRLywwoffc9SXXJYsGr5WszvzT7dlLAm3?=
 =?us-ascii?Q?349Ux/zY2Se4IVK6wgptB/+j7NQFj03DLDlvX72ZRzZPh8JQc8irO25FjFpg?=
 =?us-ascii?Q?1Pivd9NMUqbMJTwrBuPc5U5jkjOiVvRrDB2+K+BnQGyf5gKMxcWue1ZWEdll?=
 =?us-ascii?Q?nr1/ybwMdYc756+6tgAoZQmOYj+ExgjEA6jp9DQH7PSq6ufGb9O+mhv81IKT?=
 =?us-ascii?Q?KXBOQcydQOh9nILUPV6B?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <CEA7EB92EB5F3843893C9CEEF4ACEF17@sct-15-20-4755-11-msonline-outlook-3458f.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ad38c123-90e7-4fb8-8045-08dc132ee079
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 05:25:23.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3P220MB1690



Ross Nicholas Oneil Thomas
ownership of:
www.github.com
www.coinbase.com
www.jsnull.com
(559-816-2950)

