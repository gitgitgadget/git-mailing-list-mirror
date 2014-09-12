From: Stephen Smith <ishchis2@gmail.com>
Subject: Is the a way to get a log with files that were changed
Date: Fri, 12 Sep 2014 07:16:26 +0530
Message-ID: <FD6D2EE2-AD97-4D40-B461-435FD18D7E1A@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Smith <ischis2@cox.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 03:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSFwf-0005EO-PF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 03:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbaILBq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 21:46:28 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57018 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaILBq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 21:46:28 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so98123pab.40
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 18:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:from:content-type:message-id:date:cc
         :content-transfer-encoding:to;
        bh=u29d04u8D4CGuPxrBid/l9eYim995fiPSPRpRQ4hY1o=;
        b=p9V1OR32ePYk7Ev3SK2eh7qHtlCJoUm0mFblZHqfNOnEzR5fNqXuyVZp6/D1wPPrTL
         D0ZeiXSmb6TUqOzx7PR2XTbpBhABcIyGfadCVqXoRQx3P94gcl/o3WNyB8Z53u5sfut7
         2IZyfclsTc5Rh5R2bdk0ylbJ0VqFiuDhpQ4rqIXJUA7D1JI3vQ60dAHvFN8rfXnKBRR8
         VWtGF+fsdJTCoXS9pVH72j0HdcIMh739jwStk5WDqxuKfRKmoRKbLNC/9gfvobk1Awm2
         UJZrjr7AmM7yBpb3V5VCtFqF0S75mdWRNBRuv1FmZX1yo309DPFkeZiJgxfLa2GLy0sP
         hGsg==
X-Received: by 10.68.196.226 with SMTP id ip2mr6813512pbc.120.1410486387591;
        Thu, 11 Sep 2014 18:46:27 -0700 (PDT)
Received: from [10.250.251.173] ([116.212.180.68])
        by mx.google.com with ESMTPSA id pp2sm2192591pbc.66.2014.09.11.18.46.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Sep 2014 18:46:26 -0700 (PDT)
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256891>


Is there a way to get a log of first parent  commits and with each commit a entry a list of the files that were changed?

SPS
Sent from my iPhone