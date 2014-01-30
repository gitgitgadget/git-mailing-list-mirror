From: Max Rahm <ac90b671@gmail.com>
Subject: Feature Request Google Authenticator Support
Date: Wed, 29 Jan 2014 22:07:03 -0600
Message-ID: <20140130040702.GA77226@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 05:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8iun-0007S3-6u
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 05:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbaA3EHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 23:07:08 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37100 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaA3EHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 23:07:07 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so3020646ieb.14
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 20:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=SBFXHosJvPJ7sQQH86vA637JbYqaWOLGUsx70BCJS+g=;
        b=Qt6Pk3IGLKCzZ5kGtNbmRtSSrvmmW50lcq4hLuKQnO6BlBgs/uN0f6Gx1diCw7JaG5
         KI9BIu7o9LioQ76j/fxdYYYPf/ySzg4hsWTnGraTSG3JCqW/2/r7wEymEtU7uNnOzXVg
         gnmFx0mYb+iY6fLpLiMZgKuXHqDjXktQD5V6/JbKgOtcz/Xe5UJfh1lukeaI52kF+HA3
         YlLKReWDceisLnVWkpjV6vR1sa6nmiGtXvjSAIFGYFr5MwGU4OlcH4IRlmz1KRp8mBPi
         Wi2i1T8FDqKM5jKnSHy0n/dOsApvxrXCR5IwzuIT+1+TzXfJUf8AIs2oMlVlTvuURg4g
         fIPg==
X-Received: by 10.50.118.41 with SMTP id kj9mr31981590igb.37.1391054826016;
        Wed, 29 Jan 2014 20:07:06 -0800 (PST)
Received: from gmail.com (173-22-154-180.client.mchsi.com. [173.22.154.180])
        by mx.google.com with ESMTPSA id ml2sm16070867igb.10.2014.01.29.20.07.05
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 20:07:05 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241236>

Github supports google authenticator 2-step authentication. I enabled it
and how can't figure out how to connect to my github account through git.
I've looked pretty hard in the man pages and on google and can't seem to
find anything on how to set up git to work with a repository with 2-step
verification. Here's a link to my stackoverflow question with my exact
problem if there's something I'm missing.

http://stackoverflow.com/questions/21447137/git-github-not-working-with-google-authenticator-osx

As far as I can tell the feature is not supported. I'd like to be able to
use the 2-step authentication but obviously I'd like to be able to push my
code :D

Thanks in advance,
Max Rahm

--
:wq
