From: "J.V." <jvsrvcs@gmail.com>
Subject: How to pull from windows box
Date: Thu, 16 Aug 2012 07:11:28 -0600
Message-ID: <502CF180.2030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 15:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1zrQ-0001OR-VN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 15:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab2HPNLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 09:11:35 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:42357 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab2HPNLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 09:11:34 -0400
Received: by ggdk6 with SMTP id k6so2859570ggd.19
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=A/8zFDR0wxTdlToqKDiNghROL71md6aiPOTsGphd8xY=;
        b=XJ8sIxrAg8FKlN0kSogmdfyOFRWe2IDyQKFtKRaTPAcm2lUhazVkyi9xP0368QiQfP
         tAWEp53sYOH/OJJcaKrKVNdN0+fvFVdBHL6oEnPLVNy2QCw1dRXUBSLW0jxKieLnB3HZ
         uEmk411+OQbG8NicvI5EiA6r5wToTJvh7xWyyONFuM6/NDyRUYdS08HauspBoi9tnM7P
         zX0P0tvR0rUCuBxFbu5KA/kI8kUuRWeXXekqMbxlKk1o1Zm7M4/SMAXVxXS9I/mQtqWZ
         OUi6AkYhGnnlSKowp+WifYlo1yOD/1QEjS97cgfVUoRXiB6+E5O3BDLD2y1G51kZaHI6
         V8wQ==
Received: by 10.68.197.70 with SMTP id is6mr3356701pbc.64.1345122693656;
        Thu, 16 Aug 2012 06:11:33 -0700 (PDT)
Received: from [192.168.0.53] (c-98-202-16-132.hsd1.ut.comcast.net. [98.202.16.132])
        by mx.google.com with ESMTPS id rz10sm2665106pbc.32.2012.08.16.06.11.32
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 06:11:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a central/shared bare repo setup on a Linux box by our scc/build 
team.

Each developer pulls/pushes to this repo.  I have two windows boxes 
where I have cloned the repo.  I want to commit and then on my second 
windows box pull from my other box and keep those in sync until it is 
time to push to central.

What do I need to setup on each Windows 7 box to get this working?

J.V.
