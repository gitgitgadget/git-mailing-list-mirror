From: Richard Shaw <richard@aggress.net>
Subject: error: error in sideband demultiplexer
Date: Tue, 14 Jun 2011 13:20:32 +0100
Message-ID: <9E9413C214124A0980AADBDFAD7DF28E@aggress.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 14:20:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWSbp-0006JP-SK
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 14:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab1FNMUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 08:20:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50541 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1FNMUg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 08:20:36 -0400
Received: by wya21 with SMTP id 21so3843668wya.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 05:20:35 -0700 (PDT)
Received: by 10.227.2.81 with SMTP id 17mr6521531wbi.15.1308054035153;
        Tue, 14 Jun 2011 05:20:35 -0700 (PDT)
Received: from Katherine-Lothians-MacBook-Pro.local ([85.133.43.170])
        by mx.google.com with ESMTPS id b10sm4993618wbh.26.2011.06.14.05.20.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 05:20:34 -0700 (PDT)
X-Mailer: sparrow 1.2 (build 767.8)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175764>

Hi,

Could someone please give me an explanation of what the following error message means:

error: error in sideband demultiplexer

I'm seeing this intermittently when pushing up to a remote master with a post-receive hook and want to fix it, but no luck to date.

Thanks in advance

Richard 
