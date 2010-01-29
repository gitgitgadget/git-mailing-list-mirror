From: Laszlo Papp <djszapi@archlinux.us>
Subject: Implement --password option for git svn perl script
Date: Fri, 29 Jan 2010 15:17:10 +0100
Message-ID: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: normalperson@yhbt.ne, lznuaa@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 15:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Narew-00073b-5P
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 15:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab0A2ORM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 09:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606Ab0A2ORL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 09:17:11 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:63343 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab0A2ORL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 09:17:11 -0500
Received: by yxe31 with SMTP id 31so1823825yxe.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 06:17:10 -0800 (PST)
Received: by 10.101.108.6 with SMTP id k6mr1024511anm.53.1264774630572; Fri, 
	29 Jan 2010 06:17:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138317>

Hello,

It would be nice to use --pasword option on windows, like --username
option with git svn facility. I can't handle SVN repository with git
svn on windows if I'd like to authenticate myself with other user than
the default domain name of my windows.

If I use --username option, Frank Li said me it's not enough in
TortoiseGIT to provide a popup facility to type the password related
to the set --username option.

What's your opinion/suggestion/recommendation ?

Best Regards,
Laszlo Papp
