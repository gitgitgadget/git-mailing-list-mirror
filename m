From: Blind <stoycho.sleptsov@gmail.com>
Subject: question about the ultimate source tracking
Date: Fri, 22 Feb 2013 16:52:03 +0200
Message-ID: <CAGL0X-r=d2JnHCav5Vaaft2N6iHNk5Zqc6RgA9AWQqkUgHk_Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 15:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8tzF-0005nv-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 15:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab3BVOwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 09:52:09 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:34703 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab3BVOwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 09:52:07 -0500
Received: by mail-vc0-f171.google.com with SMTP id p1so443949vcq.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=6snui1fecGiag3A/iDTvvKz3QHtxu4YG52KTRKzK4L4=;
        b=PQT6575lMMCGiRgx7/fja06ByJrZCaMC6ghRkenpsf45luZ9OJfU7mmKOLUKMqCNet
         Oq469QgWIOUeEfy5aHnFAVDkqgMNpyE1Cjn15ZXV1oHKCU8OnsLqMpYYVKhKFKOyNNcS
         bwzUR+BvI0xEvlzMh+6AhEGiE3wCZXMfAuJuViT98T69e7/Seqau7QP19sAAUQz7H2Cn
         nj8jHePrNnRETRkc5hXMhhQ/54vfoZ/S4PthxWV7rh4RCyx0D/Fas0nHzIMHrlnNNxZC
         lOcD3zhQIKIDreE03A9egtwJiZoLed1bFRZMRPSbRicIjhOjlsv5RpTcVjaCzF7Hm1TA
         H87w==
X-Received: by 10.58.181.201 with SMTP id dy9mr2941058vec.34.1361544723427;
 Fri, 22 Feb 2013 06:52:03 -0800 (PST)
Received: by 10.58.55.228 with HTTP; Fri, 22 Feb 2013 06:52:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216833>

Hi there,

Going through your plans about your meetings this year,
I noticed that there is an idea since 2005,
named Linus's ultimate source tracking something (why not "Lustra" for short?).
I see its still not completed till this day.
So I decided to give it a thought. And I have an idea.
But before to continue to analyze my idea, I want to ask you a question,
because the analyzes will take some time.

Are (approximately) 10% more objects in the store a good trade
for almost immediate answer to the question which line came from where?

Blind.
