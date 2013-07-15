From: Duy Nguyen <pclouds@gmail.com>
Subject: Missing capabilities in Documentation/technical/protocol-capbilities.txt
Date: Mon, 15 Jul 2013 19:25:19 +0700
Message-ID: <CACsJy8BcEfc33HNxQB+_msbkbcxFfqg1xOpeRxNGL_cUqruE0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jul 15 14:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyhqm-0007FH-1k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 14:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab3GOMZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 08:25:52 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39529 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab3GOMZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 08:25:51 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so15771535oag.34
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=3/S7GUqfYHOq9GkPXuYmO9r97y4kAViapugwWH4ay/U=;
        b=fcVrKVcR9zRePK1Nr8KBy3E0bW+rIHyWCx153DBE0F9YAOuUlGn+uEfRWXjwWLrhVt
         2wqPTgSbIEwT8vBnKPusQ9QXpJNRQBny569z1iouXB+8rcYtEzsRczjxEJ4XXV0Nqvwc
         duH0s1lN3u58mCnnZkG5IWoWB7Um5fH4+6g9mqoxkMQThQlo7CRvIO/mtLe5dJGl0ASi
         gR+sLyuNdGpZs76y7Rp7+kkkgRJkVawWk/QdVXstQ+J0XzWjSupMYVdLZUZEIoYZIYd2
         1q3aqDPldnTT5Bg3w8Jo/Cn6GuIAQ/ZiVbWcp6P4nVBG03dyY3sh8LhK9YgemAC8+/FF
         /cmw==
X-Received: by 10.60.97.74 with SMTP id dy10mr42577823oeb.27.1373891149291;
 Mon, 15 Jul 2013 05:25:49 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 15 Jul 2013 05:25:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230460>

I noticed that "quiet" and "agent" capabilities were missing in
protocol-capabilitities.txt. I have a rough idea what they do, but I
think it's best to be documented by the authors. Maybe you have some
time to make a patch?
--
Duy
