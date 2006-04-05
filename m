From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 5 Apr 2006 15:18:34 +0200 (CEST)
Message-ID: <20060405131834.60888.qmail@web25804.mail.ukl.yahoo.com>
References: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 15:18:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR7uB-00006V-9d
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 15:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWDENSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Apr 2006 09:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDENSg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 09:18:36 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:41550 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751114AbWDENSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 09:18:35 -0400
Received: (qmail 60890 invoked by uid 60001); 5 Apr 2006 13:18:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aqa28yt1hAsdFIGQEfdnRtsfxTTnoVmblxNpf+cJcI6Gk/8FdXA7RdkuJrtV7YMiW3rIcvE3YMzfCvOOsAe3skKXVzXrRgMmoIbLkhme/5oOiBOs+o2T+ae2sfT0Kth9Vk3xv6f6OTgPTp5marLBnwSku9Azt2lMdV5Pe+WVnE8=  ;
Received: from [194.3.162.233] by web25804.mail.ukl.yahoo.com via HTTP; Wed, 05 Apr 2006 15:18:34 CEST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18429>


--- Junio C Hamano <junkio@cox.net> a =E9crit :

> If I were doing that today, I would be doing almost exactly the
> above sequence, or:
>=20
> 	$ git am patch
>         $ git add <new images>
>         $ git commit -a --amend
>=20

BTW, what does "--amend" option do ? It doesn't seem to be documented a=
nywhere.

=46rancis


=09

=09
	=09
_______________________________________________________________________=
____=20
Nouveau : t=E9l=E9phonez moins cher avec Yahoo! Messenger ! D=E9couvez =
les tarifs exceptionnels pour appeler la France et l'international.
T=E9l=E9chargez sur http://fr.messenger.yahoo.com
