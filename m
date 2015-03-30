From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 23:09:19 +0200
Message-ID: <5519BB7F.4040603@gmail.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>	<5519178A.6080408@gmail.com>	<xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>	<CAHGBnuP0mRYWyJiLvWHuqsVxMRPPtvu-QuWmcD8xXeVOXhwSDA@mail.gmail.com>	<xmqqtwx2w937.fsf@gitster.dls.corp.google.com> <xmqqoanaw7xm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 23:10:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycgwr-0007BZ-BV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 23:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbC3VKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 17:10:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:48531 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178AbbC3VKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 17:10:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YcgwW-0006wu-BM
	for git@vger.kernel.org; Mon, 30 Mar 2015 23:09:56 +0200
Received: from p4ff4572e.dip0.t-ipconnect.de ([79.244.87.46])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 23:09:56 +0200
Received: from sschuberth by p4ff4572e.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 23:09:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff4572e.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <xmqqoanaw7xm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266476>

On 30.03.2015 22:23, Junio C Hamano wrote:

> Ignoring a merge can be read as ignoring the changes a merge commit
> introduces altogether, as if the entire side branch the merge commit
> merged was removed from the history.  But that is not what happens

Sounds good to me. Thanks.

-- 
Sebastian Schuberth
