From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Is it possible for a Client to have hosted repositories with
 different attributes ?
Date: Fri, 22 Jun 2012 12:07:26 -0500
Message-ID: <4FE4A64E.50501@gmail.com>
References: <1340287586020-7561927.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lalebarde <l.alebarde@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si7Kh-0006IW-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab2FVRHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:07:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58463 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab2FVRH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:07:29 -0400
Received: by obbuo13 with SMTP id uo13so2190142obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uwxiC4jFqu8Uj7YWJNY5Y1cNwxpWMHyzaY9H8BLIP9g=;
        b=IIoEr1a5n0uOGcqDBoq5HI+csx5nD1UMnujdPbXsEelUqq/yucpuGYq05PB+Fq43ji
         46RPIAEdm6OE5hmXI7d/MCmF9v0jN175iYro4XoqSvu3I1cWbpmfLvztfe5VTPfr36uT
         9etj4u6E/YOTaZLHd6hO5FOYub8vGANbK4P8ZibPzOmdC/YfVIUUmls5wiWF0vOToaSN
         0PJ0767fEg9TA37mX45tBcrb1oFS0ysQHrsdLUMeqWIyCciPylbSg2exRVv6ZBEr+fDl
         hyDOJLbTF6xdedy8Ilp6o6jl0yC/wNSQ98700OVAr8+rMvrFnZIvIchXX6fgnHai3DZd
         nvhA==
Received: by 10.182.117.102 with SMTP id kd6mr2735689obb.23.1340384849009;
        Fri, 22 Jun 2012 10:07:29 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id fy8sm13689118obc.4.2012.06.22.10.07.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 10:07:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1340287586020-7561927.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200447>

On 6/21/2012 9:06 AM, lalebarde wrote:
> Hi all, All is in the title.
>

Hmmm.  That title could mean a lot of things.  Telling us which git 
hosting solution you are using would be helpful.  github?  I take it 
that you consider yourself a 'client' of github or something?  Or do you 
mean your pc a 'client' of a server that is the host of a git repo?  I 
assume you are referring to gitattributes assigned to a path via your 
$GIT_DIR/info/attributes, .gitattributes, etc. files?

v/r,
neal
