From: Seth Falcon <seth@userprimary.net>
Subject: Re: [PATCH] Add a --dry-run option to git-svn rebase
Date: Mon, 19 May 2008 20:24:58 -0700
Message-ID: <20080520032458.GF396@ziti.local>
References: <1211206844-29842-1-git-send-email-seth@userprimary.net> <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: "toby.allsopp (toby.allsopp - NAVMAN)" <toby.allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Tue May 20 05:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyIUD-0003Ik-KH
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 05:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbYETDZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 23:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbYETDZK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 23:25:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:45057 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbYETDZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 23:25:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1594947wfd.4
        for <git@vger.kernel.org>; Mon, 19 May 2008 20:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=dmN2i35VKKBtxv62zO622zQHzb8DvHYXmSbp2mTkFFo=;
        b=Ya3R3oWwncaCdguKBPJ4cXUMEdL8854viTL7oWCzEvPgH+ew5hdVbKlsBkzBAod/Z9hUfE5n+ST9JgjUevlAmCltNvfW1Fv0MYG32nZ+s/i4DvpfahCpT/abqzlSbWr1xmJP2lffmRbsucp9ddlOJQ09h09hwIFaDA9NKLusDjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PxDb0YVaqTnSdUs6pqEAQjF596TkQqsDQgivJUt/9W9gNV8K3JIhCaggL8xK++GVp8ClLillx2RvZV0hVaRiKSF36mwuS9b++je0RwlQyF7+4haB6GVftJWZfuhiXmZDMOJsbPY0CZ0tD7MSyMw0mz7tuFbGShTWiPSrXlpfXmY=
Received: by 10.142.158.3 with SMTP id g3mr3112838wfe.344.1211253908643;
        Mon, 19 May 2008 20:25:08 -0700 (PDT)
Received: from localhost ( [71.197.245.84])
        by mx.google.com with ESMTPS id 30sm114206wff.8.2008.05.19.20.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 May 2008 20:25:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82462>

* On 2008-05-20 at 12:19 +1200 toby.allsopp (toby.allsopp - NAVMAN) wrote:

> [resending to correct Eric's email address]

Sorry about that, typoed the address.

> s/dryrun/dry-run/ perhaps?  Also, it looks like you've used spaces
> instead of tabs.

I'll address both of those and resend, thanks.

+ seth

-- 
Seth Falcon | http://userprimary.net/user/
