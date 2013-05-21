From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Contributing to git: cleaner git -rm & add configuration options
Date: Tue, 21 May 2013 07:42:36 +0200
Message-ID: <fb43f66aed3826d04b75826e187e3e6c@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <garciagj@ensimag.imag.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 21 07:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UefLS-00049k-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 07:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab3EUFmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 01:42:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53886 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab3EUFml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 01:42:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4L5gZRc024069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 21 May 2013 07:42:36 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r4L5gaFf008387;
	Tue, 21 May 2013 07:42:36 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r4L5ga2m025708;
	Tue, 21 May 2013 07:42:36 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r4L5gao8025707;
	Tue, 21 May 2013 07:42:36 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 21 May 2013 07:42:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4L5gZRc024069
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: mathieu.lienard--mayor@ensimag.fr
MailScanner-NULL-Check: 1369719759.90864@nnAo8VOU/pd4g94xS0TfyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225017>

Hello everyone,

I'm Mathieu LIENARD--MAYOR, a french student at Ensimag - Grenoble INP, 
and together with my fellow student Jorge GARCIA we will try to 
contribute to git as our school project.

As of now, we are considering the implementation of the following two 
features:
-Cleaner error message when "git rm" fails with multiple files 
(https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Cleaner_error_message_when_.22git_rm.22_fails_with_multiple_files)
-Add configuration options for some commonly used command-line options 
(https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Add_configuration_options_for_some_commonly_used_command-line_options)

Please let us know if you think those features are interesting choices, 
or if you have some ideas about how we should do it, or even if you have 
any comment at all.

Best regards,
Mathieu LIENARD--MAYOR & Jorge GARCIA
