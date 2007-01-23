From: "Allexio Ju" <allexio.ju@gmail.com>
Subject: A trivial question on GIT
Date: Tue, 23 Jan 2007 11:45:14 -0800
Message-ID: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 20:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9RaC-0007lq-Ai
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXAWTpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 14:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXAWTpR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 14:45:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:48338 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXAWTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 14:45:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1313789uga
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 11:45:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B4BmkYOwjPYYS2N+kVCY7jmLcWvhSGusgUFiGFydW7ydyJtMdPe3L8cGRO/FCeYycy7TMNWTIc6QDUvmA1spAiq/ufkZ72VnUfajANCdUkcrJpVI+B2dljllU+QAvt7sFgD1r092MhmYaLjeVIUj2zZFnATAjbZvIqsQNjH6C7c=
Received: by 10.78.204.7 with SMTP id b7mr608652hug.1169581514271;
        Tue, 23 Jan 2007 11:45:14 -0800 (PST)
Received: by 10.78.143.1 with HTTP; Tue, 23 Jan 2007 11:45:14 -0800 (PST)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37560>

Hi,

I have trivial question on GIT.
I've made local copy of Linus's linux-2.6.git repository with
following git command,
---
# git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6.git
---

After this, I would like to know how to synchronize local copy and
keep updated  with Linus's.
I guess cloning everyday would be bad idea as it is heavy operation.
Can someone guide me on how to?


Thank you,

Allexio
