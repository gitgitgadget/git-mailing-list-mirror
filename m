From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Mon, 2 Apr 2012 21:56:14 +0530
Message-ID: <CAH-tXsA0wdtryrQ0d+31nLp+JRBnL0OMhpbOHUjMC=6N26GMDg@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
 <201203301305.23567.jnareb@gmail.com> <CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
 <201203310137.59657.jnareb@gmail.com> <CAEY4ZpNek5-8s6hG8qUos9TfNEn83Hf4KCyCcreY3MM5P9qAkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:27:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEk5w-0000Zh-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab2DBQ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:26:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56865 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab2DBQ05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:26:57 -0400
Received: by wibhq7 with SMTP id hq7so2859221wib.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NFoNix/0ozK/i3LKJRCSGd1XyXBuduMMmcrqhbQgSAU=;
        b=uSpq/ajcauH7T+E35TgElT0YbFG9mzBK4QAdoLPcVM1MISwCaWHiciDGSAD0v+jcLg
         gDV1IEnGSAccNSjAUaZjpw38A9Px9VL+lCJgAoSdGW6upJYFNm9uSbE++rFuxePUpcAS
         5f8zV7hHjqR3EP2JE+pmv0T7DR10PJsFmsxTYLHOAfZ6s4xffIUU6vrHwke1uVztUKa1
         xULgb4UHU2fOwYeO9AYbrSXXsJkFcHlAmgoIhXBgvy7k2vk3SNcSRitsCXLzjs7qCJ7u
         GSXAEdlZYzKDlGWphHq0EyMGao9mpOSJOFpEmaHUSPHfwRKL+tNNvK+TyLSZ3gwJCqfy
         zGgQ==
Received: by 10.180.95.74 with SMTP id di10mr31407948wib.1.1333384015909; Mon,
 02 Apr 2012 09:26:55 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Mon, 2 Apr 2012 09:26:14 -0700 (PDT)
In-Reply-To: <CAEY4ZpNek5-8s6hG8qUos9TfNEn83Hf4KCyCcreY3MM5P9qAkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194531>

On Mon, Apr 2, 2012 at 1:02 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Just to add to the discussion, consider these too (descriptions copied
> verbatim off their tins):
>
> 1. phantomjs[1] - headless WebKit with JavaScript API
> 2. casperjs[2] - navigation scripting & testing utility for PhantomJS
>
> [1] http://www.phantomjs.org/
> [2] http://casperjs.org/

It feels like too much for this project. Do we need all the features
from these projects? As far as I can understand, you need phantom.js
to be installed in your local development machine, which is a new
dependency.  I have an instruction from the community not to add new
dependencies.

-- 
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
