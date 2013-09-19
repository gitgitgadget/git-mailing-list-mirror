From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Thu, 19 Sep 2013 15:33:53 -0400
Message-ID: <523B51A1.7030409@bbn.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>	<522E3C6A.3070409@bbn.com> <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 21:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMjzM-00040w-KT
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 21:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab3ISTeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 15:34:04 -0400
Received: from smtp.bbn.com ([128.33.1.81]:15095 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab3ISTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 15:34:03 -0400
Received: from socket.bbn.com ([192.1.120.102]:42877)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VMjz7-0008yr-Q8; Thu, 19 Sep 2013 15:33:53 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7945840064
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235026>

On 2013-09-09 18:49, Felipe Contreras wrote:
> On Mon, Sep 9, 2013 at 4:23 PM, Richard Hansen <rhansen@bbn.com> wrote:
>> On 2013-09-08 21:23, Felipe Contreras wrote:
>>> The old configurations still work, but get deprecated.
>>
>> Should some tests for the deprecated configs be added?  We wouldn't want
>> to accidentally break those.
> 
> Probably, but Junio is not picking this patch anyway.

It sounds to me like he would with some mods:
http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234488

-Richard
