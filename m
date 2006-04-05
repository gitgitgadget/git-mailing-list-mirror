From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 5 Apr 2006 14:21:13 +0200 (CEST)
Message-ID: <20060405122113.60376.qmail@web25801.mail.ukl.yahoo.com>
References: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 14:21:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR70g-0004zu-K9
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWDEMVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Apr 2006 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWDEMVQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 08:21:16 -0400
Received: from web25801.mail.ukl.yahoo.com ([217.12.10.186]:49334 "HELO
	web25801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751235AbWDEMVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 08:21:15 -0400
Received: (qmail 60378 invoked by uid 60001); 5 Apr 2006 12:21:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BAB8yMc4NYVrL+W2/3e1VdFM5bdHtJ402KEw/z723s04jnQ6rRMg6VNRJEIqSqfwljgVmfAQUtDz+BqCriYI1FiqHXICx+QQaowmUdIym4Lx5kMmwIqLTCYnlURa1x8FmJYP3vQcabWVhUAzTTAe6vYmwLiwJG1EeMyTXLAGv6s=  ;
Received: from [194.3.162.233] by web25801.mail.ukl.yahoo.com via HTTP; Wed, 05 Apr 2006 14:21:13 CEST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18426>


--- Junio C Hamano <junkio@cox.net> a =E9crit :

> It _might_ make sense to adopt a well-defined binary patch
> format (or if there is no prior art, introduce our own) and
> support that format with both git-diff-* brothers and git-apply,
> but that would be a bit longer term project.
>=20

well maybe it's just stupid, but why not simply transforming binary fil=
es into
ascii files (maybe by using uuencode) before  using git-diff-* brothers=
 and
git-apply ?

=46rancis


=09

=09
	=09
_______________________________________________________________________=
____=20
Nouveau : t=E9l=E9phonez moins cher avec Yahoo! Messenger ! D=E9couvez =
les tarifs exceptionnels pour appeler la France et l'international.
T=E9l=E9chargez sur http://fr.messenger.yahoo.com
