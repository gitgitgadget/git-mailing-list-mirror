From: Andreas Ericsson <ae@op5.se>
Subject: Re: Migration from CVS to GIT - Multiple directories in CVS repo
 to a single Git repo
Date: Wed, 22 Jun 2011 13:55:51 +0200
Message-ID: <4E01D847.9080707@op5.se>
References: <1308733591425-6503493.post@n2.nabble.com> <4E01B44C.7090003@op5.se> <1308738087757-6503654.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 13:56:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZM2J-00085T-Uk
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 13:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429Ab1FVLzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 07:55:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43394 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377Ab1FVLzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 07:55:54 -0400
Received: by fxm17 with SMTP id 17so573969fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 04:55:53 -0700 (PDT)
Received: by 10.223.37.153 with SMTP id x25mr746610fad.117.1308743753181;
        Wed, 22 Jun 2011 04:55:53 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id e16sm284234fak.17.2011.06.22.04.55.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 04:55:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <1308738087757-6503654.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176237>

On 06/22/2011 12:21 PM, sandy2010 wrote:
> I did not understand when you say "Make a single repository out of them
> first". You mean single Git repository?

Yes.

> Infact, my requirement is same. Can
> I have a single git repository "/git/Testsuites" which will contain suite1
> and suite2 directories? Provided suite1 and suite2 are no git repositories.
> 

Yes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
