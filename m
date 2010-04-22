From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: GIT counterpart to "svn list"
Date: Thu, 22 Apr 2010 10:45:48 +0700
Message-ID: <1383223606.20100422104548@yandex.ru>
References: <20100421222237.1758ca66@pennie-farthing> <4BCFC180.5020009@dbservice.com> <20100421223716.6526f625@pennie-farthing>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 05:46:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4nMd-00009o-TA
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab0DVDp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:45:59 -0400
Received: from forward15.mail.yandex.net ([95.108.130.119]:42374 "EHLO
	forward15.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab0DVDp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:45:58 -0400
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward15.mail.yandex.net (Yandex) with ESMTP id D5904445A341;
	Thu, 22 Apr 2010 07:45:56 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1271907956; bh=75LfJyLdT+On3cFmFm50XRQkdTs2XTJwImHWqLrj2Ts=;
	h=Date:From:Reply-To:Message-ID:To:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=msMyNJLJjJ7SGIlmT9a2QZSMXcBLQg52VcOhz6nr+7DaIwvQrHoEl5dplLuzKEYmq
	 CTDrmX0VQd8777DYCLE92g6Doxuru0s6bWgKgFkGXAOMYMK+dR9ilHsAQQgFqOE3Aa
	 PWX1vomj+4jrAiJnPXTVbtvYbg1QziyT1u+SFT8k=
Received: from h88-115-252.sibinet.com (unknown [88.204.115.252])
	by smtp14.mail.yandex.net (Yandex) with ESMTPA id 830A219B80AD;
	Thu, 22 Apr 2010 07:45:56 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <20100421223716.6526f625@pennie-farthing>
X-Yandex-TimeMark: 1271907956
X-Yandex-Spam: 1
X-Yandex-Front: smtp14.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145499>

Hello!

JD> "svn list" displays which files and folders in the current
JD> directory are under version control. It's helpful in figuring out
JD> which files you still need to add to the repository. Attached is
JD> sample output from one of my directories under subversion souce control.

  How about "git status"?

---=====---
 Alexander
