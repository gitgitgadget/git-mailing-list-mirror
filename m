From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #02; Mon, 6)
Date: Tue, 7 Jun 2016 16:32:15 +0900
Message-ID: <20160607073215.GA26323@glandium.org>
References: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 09:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bABUx-0002hK-EA
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcFGHcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 03:32:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:32912 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085AbcFGHcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 03:32:21 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bABUl-0007a9-HQ; Tue, 07 Jun 2016 16:32:15 +0900
Content-Disposition: inline
In-Reply-To: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296609>

On Mon, Jun 06, 2016 at 10:58:44PM -0700, Junio C Hamano wrote:
> * mh/connect (2016-06-06) 10 commits
>  - connect: [host:port] is legacy for ssh
>  - connect: move ssh command line preparation to a separate function
>  - connect: actively reject git:// urls with a user part
>  - connect: change the --diag-url output to separate user and host
>  - connect: make parse_connect_url() return the user part of the url as a separate value
>  - connect: group CONNECT_DIAG_URL handling code
>  - connect: make parse_connect_url() return separated host and port
>  - connect: re-derive a host:port string from the separate host and port variables
>  - connect: call get_host_and_port() earlier
>  - connect: document why we sometimes call get_port after get_host_and_port
> 
>  Ok, folks, is everybody happy with this version?

Good for me, thanks.

Mike
