From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 2/2] demonstrate format-callback used in combined diff
Date: Sun, 21 Aug 2011 23:55:57 +0200
Message-ID: <20110821215556.GA2370@kolya>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
 <7vd3g0zj3l.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net, jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 23:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFzn-0002vA-TT
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab1HUVzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 17:55:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53454 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1HUVzu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 17:55:50 -0400
Received: by bke11 with SMTP id 11so3269678bke.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VX5ygyI9sGve3N/o42na8C95ALWZLCKgPnQSQkXFh34=;
        b=Cole0qoJQtKq8RnfNCKyExxGhbGDTxRMFhbD06R5JC9aeqEoWTcNo+yDfqKj3KxBm7
         wKj6Fl5Hhx4tvxNYTKJn5OOKm+HeuovnbQ4aPwtUBQgfqb/0VHAS1Gy89GBp7ARhYarN
         nc1VlTlFs7APvJHZCQhG9Ll+0ULuWRNP/5CLs=
Received: by 10.204.141.12 with SMTP id k12mr651708bku.22.1313963748922;
        Sun, 21 Aug 2011 14:55:48 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id e21sm1708390bkw.56.2011.08.21.14.55.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 14:55:47 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QvFzp-0000ej-6a; Sun, 21 Aug 2011 23:55:57 +0200
Content-Disposition: inline
In-Reply-To: <7vd3g0zj3l.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179820>

Thank you. GSoC is now finished and I have examans next week that needs
my attention. I will continue finish what I started but won't be able to
do so until the end of the weak. Just so you know...

/Fredrik Gustafsson
