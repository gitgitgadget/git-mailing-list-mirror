From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the
 revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 18:45:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11394103753694-git-send-email-ryan@michonline.com>
 <cda58cb80602080835s38713193t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 18:47:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6tNm-0005sZ-Ll
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 18:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWBHRpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 12:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWBHRpc
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 12:45:32 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55228 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030377AbWBHRpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 12:45:31 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A22E71461B5; Wed,  8 Feb 2006 18:45:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 941ED1257;
	Wed,  8 Feb 2006 18:45:30 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6A8491461B5; Wed,  8 Feb 2006 18:45:30 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80602080835s38713193t@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15744>

Hi,

On Wed, 8 Feb 2006, Franck Bui-Huu wrote:

> another perl script :(
> 
> Are there any rules on the choice of the script language ?

Yes. Do not try to introduce unnecessary dependencies. But if it is 
the right tool to do the job, you should use it. As of now, we have perl, 
python and Tcl/Tk.

Hth,
Dscho
