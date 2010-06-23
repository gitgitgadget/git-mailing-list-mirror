From: Laszlo Papp <djszapi@archlinux.us>
Subject: Uncommitted source and header files disappeared after a git mv 
	operation
Date: Wed, 23 Jun 2010 12:24:23 +0200
Message-ID: <AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 23 12:24:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORN8B-0006Te-0I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 12:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab0FWKY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 06:24:26 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33690 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0FWKYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 06:24:25 -0400
Received: by wwc33 with SMTP id 33so854922wwc.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 03:24:23 -0700 (PDT)
Received: by 10.216.157.141 with SMTP id o13mr5674950wek.5.1277288663416; Wed, 
	23 Jun 2010 03:24:23 -0700 (PDT)
Received: by 10.216.163.6 with HTTP; Wed, 23 Jun 2010 03:24:23 -0700 (PDT)
In-Reply-To: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149502>

Hello,

I have got a very big trouble, so please help me if you can :(

I have done a git mv operation for a whole directory, so I have put it
into another subfolder and all my uncommitted/unpushed source and
header files were lost ... How can I regain them ?

So I did "git mv some-directory-containing-lots-of-uncommitted-changes
total_different_folder/some-new-name". If I remember well then I did
commit/push for that git mv operation.

git status doesn't show my changes either. Do I have any chance to
avoid so that my boss fires me ?

Best Regards,
Laszlo Papp
