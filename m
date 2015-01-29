From: Dick <dick@mrns.nl>
Subject: Re: git loses commits on git pull --rebase with Dictator and Lieutenants Workflow
Date: Thu, 29 Jan 2015 19:59:02 +0000 (UTC)
Message-ID: <loom.20150129T205443-493@post.gmane.org>
References: <loom.20150128T203924-608@post.gmane.org> <xmqqlhkle64d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 20:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGvFF-0007Ae-6h
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 20:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbbA2T7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 14:59:13 -0500
Received: from plane.gmane.org ([80.91.229.3]:47901 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbbA2T7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 14:59:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YGvF6-00070S-4U
	for git@vger.kernel.org; Thu, 29 Jan 2015 20:59:08 +0100
Received: from 095-096-100-038.static.chello.nl ([95.96.100.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 20:59:08 +0100
Received: from dick by 095-096-100-038.static.chello.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 20:59:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.96.100.38 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263159>

Thanks Junio! I should use git config remote.pushDefault thanks for pointing 
me in the right direction.

I guess the git remote set-url --push command should contain some warning 
about this.

gr
Dick
