From: =?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: Re: Getting Ensimag students to work on Git for a few weeks
Date: Sat, 29 May 2010 00:53:25 +0200
Message-ID: <4C004965.6040802@ensimag.imag.fr>
References: <AANLkTikF0rvZtl5HQl9laQZryqnh4W318GB5YIc1Zp4q@mail.gmail.com> <20100522112652.GA15328@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 29 00:53:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI8R4-0002sF-Gr
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 00:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0E1Wxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 18:53:43 -0400
Received: from smtp21.services.sfr.fr ([93.17.128.1]:32104 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab0E1Wxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 18:53:42 -0400
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2118.sfr.fr (SMTP Server) with ESMTP id 707837000089;
	Sat, 29 May 2010 00:53:39 +0200 (CEST)
Received: from [192.168.1.20] (unknown [79.94.12.18])
	by msfrf2118.sfr.fr (SMTP Server) with ESMTP id 414C37000087;
	Sat, 29 May 2010 00:53:39 +0200 (CEST)
X-SFR-UUID: 20100528225339267.414C37000087@msfrf2118.sfr.fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100522112652.GA15328@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147940>

Le 22/05/2010 13:26, Clemens Buchacher a =E9crit :
> On Fri, May 21, 2010 at 07:44:42PM +0200, Matthieu Moy wrote:
>
>   =20
>> As a first exercice, they'll try to add textconv support
>> to git-blame. The next tasks are undecided yet (but advices are
>> welcome).
>>     =20
> Just FYI, there is a patch pending to add textconv support to git-gui=
=2E
>
>   http://mid.gmane.org/20100415193944.GA5848@localhost
>
> Clemens
>   =20
Thank you for this information.

As we are about to finish to add textconv support to git-blame, we'll=20
now look to add it to git-gui blame.
We wonder what would be the best choice between add a second option "Us=
e=20
Textconv For Blames", or transform the existing one (introduced by the=20
patch above) into "Use Textconv For Diffs and Blames" (so the user=20
wouldn't have the choice to use textconv only for Diffs or only for=20
Blames; is it really usefull ?).
Your advice is welcome !

Thanks,
Cl=E9ment
