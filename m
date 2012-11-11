From: Sven Strickroth <sstrickroth@gym-oha.de>
Subject: [PATCH 0/2] second try
Date: Sun, 11 Nov 2012 17:40:22 +0100
Message-ID: <509FD4F6.5050606@gym-oha.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <
 50704BB8.1020603@tu-clausthal.de> <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXahK-0000EM-I7
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab2KKQrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:47:37 -0500
Received: from trg-oha.de ([85.116.199.226]:38264 "EHLO trg-oha.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab2KKQrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:47:37 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2012 11:47:36 EST
Received: from localhost (localhost [127.0.0.1])
	by trg-oha.de (Postfix) with ESMTP id A4CA82027D;
	Sun, 11 Nov 2012 17:40:23 +0100 (MET)
X-Virus-Scanned: amavisd-new at trg-oha.de
Received: from trg-oha.de ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id gMbTPvHgORVC; Sun, 11 Nov 2012 17:40:23 +0100 (MET)
Received: from [192.168.178.22] (p5B03B3E7.dip.t-dialin.net [91.3.179.231])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sstrickroth)
	by trg-oha.de (Postfix) with ESMTPSA id BC2832027A;
	Sun, 11 Nov 2012 17:40:22 +0100 (MET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gym-oha.de;
	s=mail200904; t=1352652023;
	bh=3J7jeHfu57CHFzxzYE4H5kyODSbYGbMsEsXhcxlunC4=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=SO2vd92Lf0bY1sdYmKqw7riZMhvgAxvXa1jC4QkccKrHioSjUCNBy0W2c4CzwHo0b
	 aPlz38+vYBkGJ1QLcurvJbNw8uRBJE1nb53wb/vqO44zdVu48rOrkYLdwgY8Y5VZXi
	 IgCoQQUVc+uKWDWD/cU48PJf+N/Z6yOaz6dEe0/k=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209400>

Hi,

Am 06.10.2012 20:28 schrieb Junio C Hamano:
> It is either that it was simply forgotten, or after I wrote the part
> you quoted early in January there were discussions later that showed
> the patch was not desirable for some reason. I do not recall which.

I noticed no threads about possible problems, so I try again.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
