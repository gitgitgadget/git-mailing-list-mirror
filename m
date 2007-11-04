From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: Re: [PATCH qgit] Add support for --early-output option of git log command
Date: Sun, 4 Nov 2007 12:12:23 -0500
Message-ID: <34C93069-06F8-44DA-A18F-EE36BB457ABC@mac.com>
References: <e5bfff550711040225ne67c907r2023b1354c35f35@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 18:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioj1e-0004n8-F0
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 18:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbXKDRM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 12:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXKDRM2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 12:12:28 -0500
Received: from smtpoutm.mac.com ([17.148.16.72]:54192 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbXKDRM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 12:12:27 -0500
Received: from mac.com (asmtp007-s [10.150.69.70])
	by smtpoutm.mac.com (Xserve/smtpout009/MantshX 4.0) with ESMTP id lA4HCQem016166;
	Sun, 4 Nov 2007 09:12:26 -0800 (PST)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp007/MantshX 4.0) with ESMTP id lA4HCNE8003711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 4 Nov 2007 09:12:25 -0800 (PST)
In-Reply-To: <e5bfff550711040225ne67c907r2023b1354c35f35@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63420>

On Nov 4, 2007, at 5:25 AM, Marco Costalba wrote:

> 	bool populateRenamedPatches(SCRef sha, SCList nn, FileHistory* fh,
> QStringList* on, bool bt);

**** malformed patch at line 137: QStringList* on, bool bt);

looks like it was wrapped...

-mjc
