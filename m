From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 11:07:58 +0200
Message-ID: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 11:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myiol-00053t-8m
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 11:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbZJPJIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757047AbZJPJIh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 05:08:37 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58013 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZJPJIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 05:08:36 -0400
Received: by fxm18 with SMTP id 18so2145075fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ClIDZahK2c2GqCxNycqEzSqg1X2wFPTLcn3lN17P+fs=;
        b=KwSv/7N50eE7XYtRm8gkC/+TZnjRLNKwjjvvhZK1z08tPFau6frvhXqEx5eSvnZ7KI
         ipV0tJRsNVvGkazpF1KJ+ImzsR9/r1a0tZAv9mIBJVDenSHxKwGgRBF3G35gXZQLM8PD
         dZpEDkFWqLngU1u3wvF6agg9oVsxcXjrGEiHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hrrvvQex+QUDdoKM4N8HPnb1FmzXndTSSPnGl6Q5M/kNHF3kTQYS7o9FtKc/16HrI9
         y5zKeZsrH3W0G0dsl4nEWzXBSNtOMd0c0xzQS/LEdGndtYUvgl6q/AbtQbGgaJZkLCFd
         MaH9v76Fq67LHqlT6Y+uIPF80daPLGtTF0fog=
Received: by 10.204.10.135 with SMTP id p7mr1028847bkp.69.1255684079092; Fri, 
	16 Oct 2009 02:07:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130471>

Hi all,

I would like to say Hi! Git is great.

I made a hack to import the wikipedia changelogs into git, it is free
software and all checked in. I will be improving it to keep the git
repo in sync.

Here is the discussion on foundation-l :
http://www.gossamer-threads.com/lists/wiki/foundation/181163

the question is, is there a blame tool that we can use for multiple
horizontal diffs on the same line that will be needed for wikipedia
articles?

If not, I would work on this, if you give me some pointers.

thanks,
mike
