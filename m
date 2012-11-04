From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-archive submodule support
Date: Sun, 04 Nov 2012 17:40:54 +0100
Message-ID: <50969A96.3010703@web.de>
References: <CADyFpa7t_iCr6B8ns8QqkySRXfYtaJ8W0iseHWGz6jv62s_vzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rotem Yaari <vmalloc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 17:41:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV3G3-0008Cr-RD
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 17:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab2KDQk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 11:40:57 -0500
Received: from mout.web.de ([212.227.15.4]:53655 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2KDQk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 11:40:57 -0500
Received: from [192.168.178.41] ([91.3.190.38]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MduIT-1Tjfr80xtV-00Q8Ul; Sun, 04 Nov 2012 17:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CADyFpa7t_iCr6B8ns8QqkySRXfYtaJ8W0iseHWGz6jv62s_vzQ@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:q4h+Rl86BE1u/RMCKl5f0TClfmwSwmn2c/45ngpvJew
 UEVpKUgeAC9jhMh963tLGHiyeBAGhJCpCU6KI/nNfx2BJnMlJJ
 JnFzI/dQ+4RFwK9V/65Ilf4C3aVLIyh0I1yyQcZNU2QbP/tay7
 gPlLNPGvL/ALqX0Ag+j9iw9t0t4xzWYea8lzeg/Is43L8O9cjQ
 io8yZQXy7qTnH9PjLssvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209033>

Am 04.11.2012 15:53, schrieb Rotem Yaari:
> I was wondering if there are any plans to support inclusion of
> submodules in git-archive. This is very useful for quickly preparing
> ready-to-deploy archives of "unstable" branches etc., without the
> users' need to clone submodule dependencies each time.
> 
> Is this planned at some point? Such a change would be greatly appreciated.

It is planned but I don't expect to find the time for that in the
near future, especially as this is not my itch. But I'd be willing
to assist you in resurrecting a four year old patch for that from
Lars Hjemli. It is archived in my GitHub repo:
https://github.com/jlehmann/git-submod-enhancements/tree/archive--submodules
