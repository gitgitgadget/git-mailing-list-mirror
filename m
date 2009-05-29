From: Andreas Ericsson <ae@op5.se>
Subject: Re: git & bug tracking
Date: Fri, 29 May 2009 11:58:54 +0200
Message-ID: <4A1FB1DE.3070904@op5.se>
References: <F3DFF098-5198-4252-9F69-2805E5566155@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?fjonJyDjgYLjgorjgYzjgajjgYbjgZTjgZbjgYTjgb7jgZfjgZ/jgII=?= 
	<j.chetwynd@btinternet.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:58:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9yra-0005jo-Uv
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 11:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbZE2J6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 05:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZE2J6u
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 05:58:50 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58711 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751827AbZE2J6t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 05:58:49 -0400
Received: from source ([209.85.219.173]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh+x2pQtu0BFxLGdyybCzWeUFZ28U2n9@postini.com; Fri, 29 May 2009 02:58:52 PDT
Received: by mail-ew0-f173.google.com with SMTP id 21so8343696ewy.18
        for <git@vger.kernel.org>; Fri, 29 May 2009 02:58:50 -0700 (PDT)
Received: by 10.210.11.13 with SMTP id 13mr3980851ebk.31.1243591130216;
        Fri, 29 May 2009 02:58:50 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 5sm2230291eyf.38.2009.05.29.02.58.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 02:58:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <F3DFF098-5198-4252-9F69-2805E5566155@btinternet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120266>

~:'' =E3=81=82=E3=82=8A=E3=81=8C=E3=81=A8=E3=81=86=E3=81=94=E3=81=96=E3=
=81=84=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82 wrote:
> git & bug tracking**
>=20
> what is the reason that bug tracking was not part* of the development=
=20
> and implementation of git?
>=20

To find bugfixes to stable releases of git, you should browse the 'main=
t'
branch of git.git. Note that bugs can be related to far more than just
correctness. For instance, "it's too slow" is considered a bug. So is a
potential security vulnerability.

If that's not what you're after, you'll have to clarify.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
