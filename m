From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Date: Mon, 20 Sep 2010 21:37:00 -0400
Message-ID: <20100921013700.GC8380@foucault.redhat.com>
References: <C8BD56D1.1E331%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Grant Erickson <gerickson@nuovations.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 03:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxrnG-0003kB-Hl
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 03:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab0IUBhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 21:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab0IUBhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 21:37:04 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o8L1b3px023178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 20 Sep 2010 21:37:03 -0400
Received: from foucault.redhat.com (vpn-11-91.rdu.redhat.com [10.11.11.91])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o8L1b0oX011363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 20 Sep 2010 21:37:02 -0400
Content-Disposition: inline
In-Reply-To: <C8BD56D1.1E331%gerickson@nuovations.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156684>

On Mon, Sep 20, 2010 at 06:22:09PM -0700, Grant Erickson wrote:
> Perhaps 'submodules' are what I am looking for?
> 

Yup, exactly :) the manpage git submodule should get you going.

--CJD
