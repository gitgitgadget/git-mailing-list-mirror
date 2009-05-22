From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Fri, 22 May 2009 08:56:05 +0200
Message-ID: <4A164C85.3000703@viscovery.net>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> <1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 08:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7OgL-0005Al-0t
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 08:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbZEVG4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2009 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbZEVG4O
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 02:56:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8813 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZEVG4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 02:56:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M7Ofl-0007jA-O4; Fri, 22 May 2009 08:56:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8196A6B7; Fri, 22 May 2009 08:56:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1242899229-27603-3-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119714>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Is it possible for you to test this series on Windows? Many rebase test=
s
fail, but I haven't investigated why.

-- Hannes
