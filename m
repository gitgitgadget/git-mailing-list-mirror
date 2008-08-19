From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler	and
 ksh
Date: Tue, 19 Aug 2008 10:42:13 -0500
Message-ID: <KkHxylCPz2hua_z93fQpvqguijqEkgoLlyt8D2l7qwYTUFHOxhMPoA@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <20080819061346.GA4046@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVTMg-0003Ov-Lv
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbYHSPmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbYHSPmR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:42:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41859 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYHSPmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:42:17 -0400
Received: by mail.nrlssc.navy.mil id m7JFgEQH032639; Tue, 19 Aug 2008 10:42:14 -0500
In-Reply-To: <20080819061346.GA4046@blimp.local>
X-OriginalArrivalTime: 19 Aug 2008 15:42:13.0326 (UTC) FILETIME=[265FF6E0:01C90212]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92878>

Alex Riesen wrote:

> You can put all of it in config.mak. It is exactly what it is there
> for: build customizations.

Ah, I didn't know about config.mak. Thanks.

-brandon
