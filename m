From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 13:02:17 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC73EC0B01FA0@xmail3.se.axis.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
	 <20100322081003.GA26535@progeny.tock>
	 <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
	 <m38w9jjqqd.fsf@localhost.localdomain>
 <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"gitzilla@gmail.com" <gitzilla@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Bo Yang <struggleyb.nku@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 13:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu2p0-0003pr-EB
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0CWMCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 08:02:52 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:60661 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0CWMCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 08:02:51 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o2NC2Iwr022276;
	Tue, 23 Mar 2010 13:02:18 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 23 Mar 2010 13:02:18 +0100
Thread-Topic: GSoC draft proposal: Line-level history browser
Thread-Index: AcrKdVP210xvsOCnQZ2T4NRpp0FX8gACuu3w
In-Reply-To: <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143008>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Bo Yang
> Sent: den 23 mars 2010 11:39
> To: Jakub Narebski
> Cc: Jonathan Nieder; Junio C Hamano; gitzilla@gmail.com; Alex Riesen;
> git@vger.kernel.org
> Subject: Re: GSoC draft proposal: Line-level history browser
>=20
> Hi,
>=20
> >
> > Errr... how the first line in preimage differs from first line in
> > postimage? =A0The look as if they are the same:
> >
> > =A0- =A0 =A0 =A0 for (i =3D 0; i < extra_hdr_nr; i++) {
> > =A0+ =A0 =A0 =A0 for (i =3D 0; i < extra_hdr.nr; i++) {
> >
>=20
> Maybe some space... :)

Look more closely. Hint: a _ is not the same as a . ;)

//Peter
