From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Add git-replace to .gitignore
Date: Tue, 14 Apr 2009 08:30:12 +0200
Message-ID: <200904140830.12876.chriscool@tuxfamily.org>
References: <1239674487-47460-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtcCU-0001FC-J5
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbZDNGbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZDNGbV
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:31:21 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59190 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbZDNGbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 02:31:21 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2147F4C8066;
	Tue, 14 Apr 2009 08:31:13 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1ECE24C811F;
	Tue, 14 Apr 2009 08:31:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1239674487-47460-1-git-send-email-davvid@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116521>

Le mardi 14 avril 2009, David Aguilar a =E9crit :
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>
> This is based on the cc/replace branch in pu.

Thanks. I always forgot that.

Thanks to Nicolas Sebrecht and Junio too as they detected and fixed the=
 same=20
bug for "git bisect--helper".

Regards,
Christian.
