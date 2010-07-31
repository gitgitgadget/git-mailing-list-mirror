From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Sat, 31 Jul 2010 09:41:02 +0300
Message-ID: <20100731064102.GA20106@LK-Perkele-V2.elisa-laajakaista.fi>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
 <20100731054437.GD14425@burratino>
 <i30g2s$dpt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5jH-00011B-RN
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0GaGj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 02:39:26 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:58685 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227Ab0GaGjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:39:25 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 1233518D34C;
	Sat, 31 Jul 2010 09:39:24 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A019070FE8F; Sat, 31 Jul 2010 09:39:24 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id D38B81C6387;
	Sat, 31 Jul 2010 09:39:21 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <i30g2s$dpt$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152317>

On Fri, Jul 30, 2010 at 11:32:53PM -0700, Walter Bright wrote:
> 
> Why would "git clone" even exist if copying the directory works? Is
> it the embedded inode problem that Ilari mentioned?

Cloning remote repositories. But there are URLs for local repositories
too, so those can be cloned as well.

-Ilari
