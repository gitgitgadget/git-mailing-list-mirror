From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] Documentation: quote double-dash for AsciiDoc
Date: Wed, 29 Jun 2011 00:31:33 -0500
Message-ID: <20110629053133.GB28690@elie>
References: <20110628171748.GA11485@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 07:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbnNL-0007ja-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 07:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab1F2Fbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 01:31:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36856 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1F2Fbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 01:31:39 -0400
Received: by iwn6 with SMTP id 6so747525iwn.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CEuyJo9CrN+1nJK3YhirEJSlagYMwmSlqQzRvQbEt2I=;
        b=kdu8uND9a2EacbQdapBZN0J9T0aI2xzgn9QfCckK/bT679FXnGbJIV+26emtYZdnC2
         9225BlaEyjQy0wsx8vTb3Wv6SWEBmJBUShGv3YvW4DT3i/E2bvzPf/X6AEaQGGEqUxbf
         tyi88RPR/59vhqGMgUJY0Y41mCeWO3XW0bsqk=
Received: by 10.42.169.68 with SMTP id a4mr386692icz.301.1309325498164;
        Tue, 28 Jun 2011 22:31:38 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.sbcglobal.net [69.209.66.254])
        by mx.google.com with ESMTPS id j1sm442962ibg.55.2011.06.28.22.31.36
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 22:31:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110628171748.GA11485@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176434>

Hi,

Thanks to Peff and Junio for comments.  This version is split into two
patches: the first applies to "maint", the second "master".

Jonathan Nieder (2):
  Documentation: quote double-dash for AsciiDoc
  Documentation/i18n: quote double-dash for AsciiDoc

 Documentation/config.txt                |    2 +-
 Documentation/git-commit.txt            |    2 +-
 Documentation/git-mergetool--lib.txt    |    2 +-
 Documentation/git-revert.txt            |    2 +-
 Documentation/git-sh-i18n--envsubst.txt |    6 +++---
 Documentation/git-sh-i18n.txt           |    2 +-
 Documentation/git-submodule.txt         |    2 +-
 Documentation/git-web--browse.txt       |    2 +-
 Documentation/rev-list-options.txt      |    2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.7.6
