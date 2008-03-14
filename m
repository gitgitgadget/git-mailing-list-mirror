From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: help: explain 'man.viewer' multiple values
Date: Fri, 14 Mar 2008 06:15:25 +0100
Message-ID: <200803140615.25266.chriscool@tuxfamily.org>
References: <20080313064846.b6b54c11.chriscool@tuxfamily.org> <200803140100.m2E107Zl004673@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja2BU-0004Sa-Rd
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYCNFJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 01:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYCNFJp
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:09:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36869 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbYCNFJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 01:09:44 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 205BA1AB2CB;
	Fri, 14 Mar 2008 06:09:44 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B9A911AB2C5;
	Fri, 14 Mar 2008 06:09:43 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803140100.m2E107Zl004673@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77179>

Le vendredi 14 mars 2008, Xavier Maillard a =E9crit :
>     man.viewer::
>    -	Specify the program that will be used to display help in the
>    +	Specify the programs that may be used to display help in the
>
> I would have prefered the following wording:
>
> "List of viewer candidates used to display help in"
>
>    +If everythings fails the 'man' program will be tried anyway.
>        ^^^^^^^^^^^
> everything :)

Thank you Xavier for reviewing and testing my patches.
But as my patch has already been commited (in next), could you send a p=
atch=20
on top of it ?

Thanks in advance,
Christian.
