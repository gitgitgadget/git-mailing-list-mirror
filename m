From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Filenames and prefixes in extended diffs
Date: Fri, 15 Jan 2010 22:32:59 +0900
Message-ID: <20100115223259.6117@nanako3.lavabit.com>
References: <201001131713.05505.agruen@suse.de> <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmIY-00043l-6a
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 14:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0AONdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 08:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207Ab0AONdE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 08:33:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:54160 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046Ab0AONdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 08:33:02 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 4959816F48C;
	Fri, 15 Jan 2010 07:33:02 -0600 (CST)
Received: from 5526.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id DXH9BUVYVYXM; Fri, 15 Jan 2010 07:33:02 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=m8O27Z2xHMEVi0SuKTeIs0F5MQAODpnkd+X5aIYaOF7Zdr+F7aMDSvtnFTXzVjfVmZ1pZx/GdSIScRKirqfEeo5DD2z0KzUy7KeTFbStRmS+kEff5cLi8p4LZ7XJ/ngHgF309/Uq9rBQbz3H790QCPEcrjghYpPP7xvxDLdVJJU=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137068>

Quoting Junio C Hamano <gitster@pobox.com>

> The output from "git diff --no-index" is an exception to the above rule.
> It is primarily for people who have unmanaged contents and want to use
> features of the git diff engine that are not found in other people's diff
> implementations (e.g. wordwise colored diff),...

Is it possible to give --no-index option to "git grep", please?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
