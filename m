From: matveevma <matveevma@jinr.ru>
Subject: ssh key
Date: Sat, 28 May 2016 16:47:06 +0300
Message-ID: <5c45dd8c03d2a9e0079796ce6850af9f@jinr.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 15:55:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6ehz-0002zD-Bm
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 15:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbcE1NzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 09:55:04 -0400
Received: from mail.jinr.ru ([159.93.14.110]:41581 "EHLO mail.jinr.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbcE1NzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 09:55:03 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 May 2016 09:55:02 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.jinr.ru (Postfix) with ESMTP id 3F57E40A01A
	for <git@vger.kernel.org>; Sat, 28 May 2016 16:47:08 +0300 (MSK)
X-Virus-Scanned: amavisd-new at jinr.ru
Received: from mail.jinr.ru ([127.0.0.1])
	by localhost (mail.jinr.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBEEalKOxHLT for <git@vger.kernel.org>;
	Sat, 28 May 2016 16:47:08 +0300 (MSK)
Received: from webmail.jinr.ru (webmail.jinr.ru [159.93.14.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: matveevma)
	by mail.jinr.ru (Postfix) with ESMTPSA id 18F2640A019
	for <git@vger.kernel.org>; Sat, 28 May 2016 16:47:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jinr.ru; s=mail;
	t=1464443228; bh=DHJu0wmJukFOsoN7ZJl0XYJsL96uvTf7bKr5tpo9+ik=;
	h=Date:From:To:Subject;
	b=WFsIEHh2lEjXAEcjWNefvkiWglFNazkWml0U66ypNtr1tR6I7GxImNLu0pkW0OcUf
	 LPhBMajxcU3UPkO70/TYsBD2YpEkFw7RKdeN0lF8OV8dbrGer/hRyUogmEVNeO4miR
	 lz1Ia4zTJm13ZDoNxO51/qJcqxPVenMk6FuvpWjg=
Received: from [185.48.37.30]
 by webmail.jinr.ru
 with HTTP (HTTP/1.1 POST); Sat, 28 May 2016 16:47:06 +0300
X-Sender: matveevma@jinr.ru
User-Agent: JINR Webmail/1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295813>

Hi,

Can i add SSH id_rsa.pub to GIT by shell terminal?

Thank you!

Mikhail.
