From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/8] archive: support creating archives from index
Date: Wed, 08 Apr 2009 22:48:43 +0200
Message-ID: <49DD0DAB.8090609@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <1239185133-4181-5-git-send-email-pclouds@gmail.com> <1239185133-4181-6-git-send-email-pclouds@gmail.com> <1239185133-4181-7-git-send-email-pclouds@gmail.com> <1239185133-4181-8-git-send-email-pclouds@gmail.com> <1239185133-4181-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:50:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrej9-0000zd-Ku
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760105AbZDHUs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 16:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757671AbZDHUs6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 16:48:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:59273 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbZDHUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 16:48:57 -0400
Received: from [10.0.1.101] (p57B7EF55.dip.t-dialin.net [87.183.239.85])
	by india601.server4you.de (Postfix) with ESMTPSA id 144B02F8043;
	Wed,  8 Apr 2009 22:48:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239185133-4181-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116121>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> This is more or less for fun. Does anyone really want to create archi=
ves
> from index?

Perhaps, but I think it would be better implemented similar to git grep=
=2E

Ren=C3=A9
