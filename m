From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Set process-environment instead of invoking env
Date: Wed, 20 Feb 2008 12:21:28 +0100
Message-ID: <87y79fvpon.fsf@wine.dyndns.org>
References: <87r6f958k5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Feb 20 12:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRn1i-0003EJ-Nv
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 12:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbYBTLVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2008 06:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbYBTLVj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 06:21:39 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33912 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYBTLVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 06:21:38 -0500
Received: from adsl-84-226-12-78.adslplus.ch ([84.226.12.78] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JRn11-00067H-KG; Wed, 20 Feb 2008 05:21:37 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id D84931E715C; Wed, 20 Feb 2008 12:21:28 +0100 (CET)
In-Reply-To: <87r6f958k5.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of
	"Tue, 19 Feb 2008 15:01:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74509>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> This will make it a little less posix-dependent, and more efficient.
>
> Included is also a minor doc improvement.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>

Acked-by: Alexandre Julliard <julliard@winehq.org>

--=20
Alexandre Julliard
julliard@winehq.org
