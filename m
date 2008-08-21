From: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 02:25:24 +0200
Message-ID: <48ACB5F4.3000905@sneakemail.com>
References: <48ACB29C.7000606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 02:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVy0X-0001WE-Dp
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYHUAZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 20:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbYHUAZ3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:25:29 -0400
Received: from morch.com ([193.58.255.207]:55457 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYHUAZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 20:25:29 -0400
Received: from [192.168.1.214] (ANice-157-1-115-112.w90-41.abo.wanadoo.fr [90.41.26.112])
	by morch.com (Postfix) with ESMTP id F38462771
	for <git@vger.kernel.org>; Thu, 21 Aug 2008 02:28:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48ACB29C.7000606@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93077>

H. Peter Anvin hpa-at-zytor.com |Lists| wrote:
> Given the recent change of "git-foo" to "git foo", it would be really=
=20
> nice if one could type, for example:
>=20
>     man git clone

Sorry man that behaviour is the way "man" works. See "man man".

   $ git clone --help
or
   $ git help clone

work right?

Peter

P.S: man, there are puns in that...
--=20
Peter Valdemar M=C3=B8rch
http://www.morch.com
