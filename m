From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 5/5] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Wed, 07 Aug 2013 18:51:42 +0200
Message-ID: <52027B1E.3080101@web.de>
References: <51F8187F.7040603@web.de> <51F81957.1000709@web.de> <52014B4D.3090602@web.de> <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 18:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V76xp-0007aF-C4
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 18:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632Ab3HGQvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 12:51:47 -0400
Received: from mout.web.de ([212.227.15.3]:62300 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932395Ab3HGQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 12:51:44 -0400
Received: from [192.168.178.41] ([91.3.171.84]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M73WL-1W3joo0uOb-00wlVx for <git@vger.kernel.org>;
 Wed, 07 Aug 2013 18:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:kVyFmd/PAcwmQEUbBWXA07ra0K3Xk1C3nxQCk/ueGGocRb5Y/d0
 IdRYOlMny9fZvFAekW+2wA8jGEaskoNGwq+eoX9f3kSsNf8sU6NgJxCxMpHvQkRRR51NtLp
 ipMHpJQh3xw13aUxHIMLkH2n6GKAo9CLe9b9DYEjipqTfnUmAxpGDNsgldNApbwvYhp9GiI
 cEDlWXEXsPwCexGCV0eoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231838>

Am 06.08.2013 23:11, schrieb Junio C Hamano:
> Thanks, will replace the top two commits and queue.  Looks like we
> are getting ready for 'next'?

I hope so, I'm not aware of any open issues.
