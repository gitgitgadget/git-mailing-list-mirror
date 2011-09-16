From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] bash: add --word-diff option to diff [AND
 --set-upstream TO push] auto-completion
Date: Fri, 16 Sep 2011 15:47:22 -0500
Message-ID: <20110916204722.GD4683@elie>
References: <4E6F720A.3020103@yahoo.com.br>
 <20110913165847.GB11076@elie>
 <4E6FA541.7000100@yahoo.com.br>
 <20110913191448.GC14917@elie>
 <20110913232941.GC2078@goldbirke>
 <20110913233712.GE2078@goldbirke>
 <4E737199.1000107@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@fzi.de>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Rodrigo Rosenfeld Rosas <lbocseg@yahoo.com.br>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fJr-0000x1-D7
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab1IPUr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:47:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47981 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab1IPUr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:47:26 -0400
Received: by ywb5 with SMTP id 5so3190981ywb.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aGYWw+r8SKZ4TtGN7SZz8h1ekgv+dg+kcJPreVIpXm8=;
        b=GFG98zQnTddafTUw+aoSt3Ky0a+cdR/5Ym3EPc0K2CTfsvDQtEFQkzQhmkIlF+5kFB
         MzUzx86DdHRixuZjI3BX5woeCQSTNka7bYCsU90UToRI07YRkQWKXa4VAc3j/cf7bC11
         iBqW9JpxRO5ck0kYjj9JGYWDX1S2GmNaqtP44=
Received: by 10.42.115.198 with SMTP id l6mr3398565icq.132.1316206045311;
        Fri, 16 Sep 2011 13:47:25 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id gs23sm10914323ibb.1.2011.09.16.13.47.24
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 13:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E737199.1000107@yahoo.com.br>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181555>

Rodrigo Rosenfeld Rosas wrote:

> While on the topic, it would also be interesting to add "--set-upstream" to
> "git push" autocompletion. Don't you agree?

Yes, of course.
