From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Sun, 16 Nov 2008 12:50:44 +0100
Message-ID: <49200914.6090506@op5.se>
References: <491DE6CC.6060201@op5.se> <200811151615.42345.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 16 12:52:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1gAj-0003B2-1n
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 12:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYKPLux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2008 06:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYKPLux
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 06:50:53 -0500
Received: from mail.op5.se ([193.201.96.20]:46827 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbYKPLuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 06:50:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CAB591B80C10;
	Sun, 16 Nov 2008 12:45:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XhVA8mj9XSa2; Sun, 16 Nov 2008 12:45:29 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id BA25A1B803D3;
	Sun, 16 Nov 2008 12:45:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200811151615.42345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101122>

Christian Couder wrote:
> Hi Andreas,
>=20
> Le vendredi 14 novembre 2008, Andreas Ericsson a =E9crit :
>> I've been working quite a lot on git -> libgit2 code moving,
>=20
> It would be nice if there was somewhere on the web where your work co=
uld be=20
> seen. If there is already, could you send (or resend) the URL? This w=
ay=20
> people might have look and perhaps even help you. (Though I don't pro=
mise=20
> anything as I have already a lot of things on my TODO list.) Thanks i=
n=20
> advance.
>=20

When I was about to, I realized these licensing issues actually made it
illegal to do so without getting the permissions from the involved auth=
ors.
Now that Linus and a lot of other core contributors have given their co=
nsent,
I'll be able to start re-ordering the commits so I can publish those pa=
rts
originating from consenting authors while holding off on those that I c=
an't
tell for sure are ok with it. Legal issues are no fun what so ever.

>> but the licensing stuff is a bit depressing, as I can't know
>> if the work I'm doing is for nothing or not.
>>
>> The license decided for libgit2 is "GPL with gcc exception".
>> Those who are OK with relicensing their contributions under
>> that license for the purpose of libgit2, can you please say
>> so?
>=20
> It's ok to relicense my git related work under the "GPL with gcc exce=
ption"=20
> license.
>=20

Thank you. With the current list of ok's 73.09% of the code in git.git
seems to be relicenseable for the purpose of libgit2. That will provide
quite a kickstart.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
