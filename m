From: Steven Grimm <koreth@midwinter.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 30 May 2008 15:00:01 -0700
Message-ID: <E718F523-70B9-4742-B291-CDBE4790A278@midwinter.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Ceh-0006KX-7Z
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbYE3WAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbYE3WAF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:00:05 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58945 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753384AbYE3WAE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:00:04 -0400
Received: (qmail 22735 invoked from network); 30 May 2008 22:00:02 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=TR56wrMU1LzTAwHukbNupbhK+9K9vwofXEHIlwDS6T4lqzvr2w5y2tNduxEre+gP  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 30 May 2008 22:00:02 -0000
In-Reply-To: <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83347>

On May 30, 2008, at 1:44 PM, Junio C Hamano wrote:
> [Stalled]
>
> * dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
> - Eliminate an unnecessary chdir("..")
> - Add support for GIT_CEILING_DIRECTORIES
> - Fold test-absolute-path into test-path-utils
> - Implement normalize_absolute_path


The most recent version of this patch seemed to come and go without  
any commentary one way or the other. What are people's objections to  
it as it stands now?

-Steve
