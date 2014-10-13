From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: msysgit works on wine
Date: Mon, 13 Oct 2014 12:02:56 +0200
Message-ID: <543BA350.2020503@redhat.com>
References: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com> <5437CAEC.1020902@virtuell-zuhause.de> <CACsJy8DJ6SwHujLNx9fj2WazJk2E6HOhfpL60AY3QtMDx7200A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 12:03:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdcT4-0004cF-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 12:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbaJMKDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 06:03:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59822 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbaJMKDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 06:03:00 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9DA2wNI012758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2014 06:02:58 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s9DA2unF002931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 13 Oct 2014 06:02:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <CACsJy8DJ6SwHujLNx9fj2WazJk2E6HOhfpL60AY3QtMDx7200A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2014 02:04 PM, Duy Nguyen wrote:
> On Fri, Oct 10, 2014 at 7:02 PM, Thomas Braun 
> <thomas.braun@virtuell-zuhause.de> wrote:
>> Are you compiling git.git or msysgit.git?
> 
> git.git
> 
>> And how about the test suite?
> 
> running right now, fingers crossed.. kinda slow, not sure if it's
> wine or it's the msys thing.
We (Wine) are interested in bug reports for git tests failing on Wine
that succeed on Windows/Linux. Performance issues compared to Windows
are highly desired too.

thanks
bye
	michael
