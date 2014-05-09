From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] svn-fe: Conform to pep8
Date: Thu, 8 May 2014 19:46:33 -0700
Message-ID: <20140509024632.GI9218@google.com>
References: <1399603010-2429-1-git-send-email-1007380@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:46:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wiapc-00077P-SK
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbaEICqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:46:37 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50499 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbaEICqg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:46:36 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so3750539pab.11
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PPHfMNZKMG1CwZI3Xp5QCJSeF9cIayMKNDAlk6vKnvU=;
        b=znaRGAllBaP2TkNe0JQjZbUCe9iQbQ2Zfb/q1u+O2UowUyBDw3hJQ3RhoiUG6fkOby
         1VnMiFqyW73PYc1B6bqxbfVAOCZr4NfSlsxUFvgsQF9YhrWiGvrevhROfAXisKBy8yHC
         uCLxraua5C6R6MZwFStoYF9sfFAsWqv5WCmpACwz41uDy+ht1BRDd3uLQrReDONHtyTJ
         2Cx+Lvywz7iJwOAdKSQ0UgKpbfVi5UQ6y50ILRocvpPpDNrAe6hLVTJ+UD91rEWbZpZN
         qIT/SPP2DbjmnAbsqr2ciO7yxaeASaNklpr8TVCrt1n9et2F+XvL5HjiXBVI7+heOTAn
         DQGw==
X-Received: by 10.66.146.105 with SMTP id tb9mr3258318pab.157.1399603596309;
        Thu, 08 May 2014 19:46:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id de5sm4536989pbc.66.2014.05.08.19.46.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 May 2014 19:46:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399603010-2429-1-git-send-email-1007380@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248508>

Hi,

William Giokas wrote:

> Quite a large change, most of this was whitespace changes, though there
> were a few places where I removed a comma or added a few characters.
> Should pass through pep8 and pass every test.

Thanks!  Mind if I forge your sign-off?  (See
Documentation/SubmittingPatches section (5) "Sign your work" for what
this means.)

Jonathan
