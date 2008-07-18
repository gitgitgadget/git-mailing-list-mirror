From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 17:50:40 +0900
Message-ID: <20080718175040.6117@nanako3.lavabit.com>
References: <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 10:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlhD-0000mv-P2
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 10:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbYGRIvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 04:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYGRIvK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 04:51:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41131 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbYGRIvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 04:51:09 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 8B22FC8409;
	Fri, 18 Jul 2008 03:50:59 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 92N2YT19OGCG; Fri, 18 Jul 2008 03:51:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=6dmHHveaexEzaXjQ/Cn//nptOuXeQ18UOUvY6RpB44ySo+WkqBra0sucyuSnUzIFezPkyHRLLjPAoQrcWXsnSjAtE+OWOwLyxFBRfGPiL5XsPIGz82odCUgPeeHPB5+KImUPki9OYZc0BloOceCU17oVnXQMYAHtfN+ElGUON8Q=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89010>

Quoting Junio C Hamano <gitster@pobox.com>:

> * xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
>  + Teach git-merge -X<option> again.
>  + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
>  + builtin-merge.c: use parse_options_step() "incremental parsing"
>    machinery
>  + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next
>
> This needs to be merged to master iff/when merge-theirs gets merged,
> but I do not think this series is widely supported, so both are on hold.

Why do you say it is not widely supported?  I may be wrong but I think you developed these patches after somebody from the mailing list asked for this feature.

You may find out people are enthusiastic about this only after you merge it to your master branch.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
