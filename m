From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] Test cccmd in t9001-send-email.sh and fix two bugs
Date: Wed, 10 Jun 2009 19:38:44 +0200
Message-ID: <4A2FEFA4.1020708@gmail.com>
References: <1244655243-12914-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MERlW-0003lz-TC
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 19:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558AbZFJRjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbZFJRjA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 13:39:00 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:51992 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758610AbZFJRi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 13:38:58 -0400
Received: by ewy6 with SMTP id 6so1205151ewy.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Jr60k+11g/eL+CG1PMLB/bj93jMF9NfWu1Ih1PjJFiA=;
        b=XgWpecN8Vqv3hpG6g3XVIUho+l4NF70EoF3l/gF/Fw2FrfTXdeiLY0d++iuu78d+1Z
         5kySGDomNhrtoxb1dVWi9kCUI7RquuBZvFYQsfzx6vganwnH2S5LZ301kpgspuQIo2s0
         k3fczstsgyUOesODMghDQ1DkLFSvgOwYd7RqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iXfnLXfJ8x0QibP4p8mXwyOGtnjtLWXfBzWR/hYRzgoesV+bKl5TbregYrCrgZDIa0
         4lKZypqDq2lXqplr0E0p/xjZOx99alkwx81ZzMxddUVDlVTeFhSUZF/zkkV5oNq1ABT9
         8gWh0KDrK+wWXLc7W7HQ3wGkyVZinbtVVYP0A=
Received: by 10.210.38.5 with SMTP id l5mr1990243ebl.4.1244655537560;
        Wed, 10 Jun 2009 10:38:57 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 28sm115314eyg.24.2009.06.10.10.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 10:38:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <1244655243-12914-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121289>

Signed-off-by:  Paolo Bonzini  <bonzini@gnu.org>

Oops.

Paolo
