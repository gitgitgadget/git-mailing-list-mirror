From: "Rahul Chandrashekar (RBEI/EMT2)" <Rahul.Chandrashekar@in.bosch.com>
Subject: RE: OSLC connectivity to GIT in Java
Date: Tue, 14 Aug 2012 10:58:39 +0800
Message-ID: <A8EF229C37FCBD4CAC33610E4F20C5DE1C27916710@SGPMBX01.APAC.bosch.com>
References: <1344859929250-7564860.post@n2.nabble.com>
 <CACPiFCK_diX36uS6SCigO4VQZ4ghBVd2Dk3a_FWajBgoqQR8rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 04:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T17Ll-0007aS-6a
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 04:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab2HNC7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Aug 2012 22:59:16 -0400
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:56872 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab2HNC7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2012 22:59:15 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 9370228C01F4;
	Tue, 14 Aug 2012 04:59:11 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id A02321B406FD;
	Tue, 14 Aug 2012 04:59:11 +0200 (CEST)
Received: from SI-PUB1000.de.bosch.com (10.3.153.157) by si-hub06.de.bosch.com
 (10.3.153.48) with Microsoft SMTP Server (TLS) id 8.3.264.0; Tue, 14 Aug 2012
 04:59:03 +0200
Received: from sgphub11.APAC.bosch.com (10.187.48.74) by
 SI-PUB1000.de.bosch.com (10.3.153.157) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Tue, 14 Aug 2012 04:59:03 +0200
Received: from SGPMBX01.APAC.bosch.com ([10.187.48.231]) by
 sgphub11.APAC.bosch.com ([10.187.48.74]) with mapi; Tue, 14 Aug 2012 10:58:40
 +0800
Thread-Topic: OSLC connectivity to GIT in Java
Thread-Index: Ac15jCRbOQuEzOWuS2+gv9431xO1aAAPF1zg
In-Reply-To: <CACPiFCK_diX36uS6SCigO4VQZ4ghBVd2Dk3a_FWajBgoqQR8rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203381>

Hi Martin,

Thanks for the feedback, do you have any Links using which I can get th=
e below scenario, as a matter of fact I am new to the below protocol an=
d am taking baby steps for the same.


Mit freundlichen Gr=FC=DFen / Best Regards,
Rahul Chandrashekar

Robert Bosch Engineering and Business Solutions Limited
Engineering Methods and Tools (RBEI\EMT2)
123, Industrial Layout, Hosur Road, Koramangala,
Bangalore - 560 095
INDIA
www.bosch.com

Tel. +91 80 6657 1661
VoIp. +49(711)811-3615170
Mobile +91 9886944213
rahul.chandrashekar@in.bosch.com


-----Original Message-----
=46rom: Martin Langhoff [mailto:martin.langhoff@gmail.com]
Sent: Tuesday, 14. August 2012 1:15 AM
To: Rahul Chandrashekar (RBEI/EMT2)
Cc: git@vger.kernel.org
Subject: Re: OSLC connectivity to GIT in Java

On Mon, Aug 13, 2012 at 8:12 AM, rahul.chandrashekar
<rahul.chandrashekar@in.bosch.com> wrote:
> I am interested to connect to a GIT SCM through OSLC.

It seems to me a very strange request. There is a very well
implemented, fit-for-purpose "git protocol". OSLC, after some
googling, is a REST-style definition over HTTP.

We already have a git-over-http protocol, not very efficient but opens
a window of opportunity to those behind unreasonable firewalls.
Perhaps it is a starting point for you.

hth,



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
