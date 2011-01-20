From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 12:14:56 +0100
Message-ID: <ih95fg$62b$1@dough.gmane.org>
References: <ih1449$ul6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 20 12:15:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfsU3-0007ho-T4
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 12:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab1ATLPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 06:15:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:41997 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab1ATLPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 06:15:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PfsTt-0007Zi-MD
	for git@vger.kernel.org; Thu, 20 Jan 2011 12:15:09 +0100
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:15:09 +0100
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:15:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165309>

Stephen Kelly wrote:

> 
> Hi,
> 
> On Friday we had an issue where a developer pushed a branch called HEAD to
> the remote server. The result was that other developers could not pull or
> push. 

Does anyone have any thoughts/response on this?

Why does git not have a bug tracker?

Steve.
