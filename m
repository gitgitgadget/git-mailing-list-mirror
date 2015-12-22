From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 22 Dec 2015 12:45:00 -0800
Message-ID: <20151222204500.GA5243@google.com>
References: <1450793432-9345-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 21:46:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBTpC-0008IJ-7c
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbbLVUp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 15:45:56 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34214 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbbLVUpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 15:45:46 -0500
Received: by mail-pf0-f172.google.com with SMTP id u7so65119023pfb.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 12:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sjLcGVOIENHtxQokq8V7rnXeSaCNiQAOVE7OTGo/LQ4=;
        b=P+gkmnXVIZcsYqEgVCgn1JDsAxaRZqaQVylMJzxF+tP7RQJTQpgu9UOsqCEqvDEM0j
         yn3Iw/c0qJ6PqclQIilKAK4Hp/nezpz6wP4LNn4lJBO43EMDOzvemgdIo4grmYQ1/40P
         NIIDNJMXMtq2umhnRQoDzQ3hJErSkmymAKriTXQrNPiZGzoyhqrzHmME4ozvBB5dN4R+
         1DR9rLC5/x1nz4hKVXsN33p8l2i9bn4CCRJylnc3NdRnKoJb09Q3FC1VyGbREwTixnJf
         t51x+nKEb89S9Iwt/4uBCc3GkVJYgdYSQqM3i0G6ZWj1L40sD9nIl0I4ErZD++4aAUGe
         Lk8Q==
X-Received: by 10.98.73.71 with SMTP id w68mr27860670pfa.138.1450817145434;
        Tue, 22 Dec 2015 12:45:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e506:fd7e:5081:5912])
        by smtp.gmail.com with ESMTPSA id x12sm43096267pfi.21.2015.12.22.12.45.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Dec 2015 12:45:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450793432-9345-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282906>

Elia Pinto wrote:

> This is the first series, the other will be sent separately.

FWIW,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
