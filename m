From: "Morten Welinder" <mwelinder@gmail.com>
Subject: git-annotate
Date: Fri, 24 Feb 2006 10:21:27 -0500
Message-ID: <118833cc0602240721s1c64219y161cc0536fb361e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 24 16:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCelL-000784-Ah
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 16:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBXPV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 10:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBXPV2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 10:21:28 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:12085 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932186AbWBXPV1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 10:21:27 -0500
Received: by pproxy.gmail.com with SMTP id f25so408437pyf
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 07:21:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qhjdq4rXPkh34543ppNJtJOPFUbkC5xCFl3uka5xPWc9yrgKEGSw0UtaIPN+RtvXMWiFp3mZ8PUPMWi9K5JBWNVgmGXol4OvqznSURI2Old/SlcnVzFHyqDcV+BSHk5jewau/7FHKpwpla2pFw6UcbgE/qhy/M8K2rVmJTBiG3U=
Received: by 10.35.50.9 with SMTP id c9mr245365pyk;
        Fri, 24 Feb 2006 07:21:27 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Fri, 24 Feb 2006 07:21:27 -0800 (PST)
To: "GIT Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16706>

git-annotate ought to call usage() if it doesn't get its file.

M.


> git annotate
Use of uninitialized value in open at
/scratch/welinder/git/git-annotate line 40.
Failed to open filename: No such file or directory at
/scratch/welinder/git/git-annotate line 40.
