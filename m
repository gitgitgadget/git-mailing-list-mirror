From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 16/20] mingw: mark t9100's test cases with appropriate
 prereqs
Date: Wed, 27 Jan 2016 17:33:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601271732280.2964@virtualbox>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de> <4c963d60edda50c110ba01150d745a2b8ebc66e0.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:33:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOT2Z-0005CF-LC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933526AbcA0Qdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:33:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:50213 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158AbcA0Qdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:33:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lfolq-1Zj2fr0Rx4-00pHyR; Wed, 27 Jan 2016 17:33:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <4c963d60edda50c110ba01150d745a2b8ebc66e0.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nycE/KECCDE6gO6+LTLwcT3jr+U51Zow4ZOmU9JwBrxbicCtDH+
 z+ha1t644JqU8p2iduHeXKWI/NPnQbIrpo2MggAOcTo5Iw2Ds2/BdYCOjQO0jHn/b31aj3u
 tVMNgblowGZpFilfpqTcXbC5Gb6sI7crmUegpcJBzUDqELRz0c33zzmapaG5Ec7t/CRKwjB
 U/tYDdQS9G3dmUe9tcHrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zJHPx1Du2Oc=:6egw7AxwafkoR4Z2iueIwN
 4+RTLquoB28CPvB02lfSGJEFjIse6Ano2Vf/u+FRPT6Fpir3KAChnxWqwjrXrX89NsN/1Rfj8
 UgTQMZPebwXLqW6KLwlTEE9Hrp5mooU7N4XZziZeeAokgzI9cWfztK/WG8OctkqEGZBnxSL2D
 qb0RIuyBs15V0Guwv3dJe4+hEN6SgwvP73klZywkf8EbnD51no8mc57Rvkb3UjEZbu0HgOjWN
 Uw3sf2J0lkPrm4BMeE1Vm3nTpLZktv24GgdTlgNRhewFavNE05SOJk53BnZ3wRFCtpJ8bWnv4
 w4yyJjJ/1qizXL/VtXB42A7ALQf5VDt1IkqVBg654vAYBMB5ufJ7KNpSx4GRjkVRODRyENBrE
 flFKtzUIWt7l+fZxI1cbdQcJrpNkkzEeycNR8p8pMsz4d8f+hzf44Lz4rD99vt2bbOPc8bB7c
 74bM68Jj81y8/GRxZ/b7XKBa2NOmHIhqI3vHizCZStWdZP5w3p9sqbFAlvNNzh+Qjnt5UKnY6
 G8z/z+1yeIVY7GX98GgisA18FdVurTFbn3hI1P/n9EVrudFRG0rYiUe7lOA4u5LGCkzbyBqhh
 /ZtOE5tHtuKXY7EQhxIgxaGIRUcgAiBZR6iY+3jHP6X45Pz9yL0a33SQOEeZN27NUNaM4wcD9
 UT4T9Oo/0NOXMr17oqIo1Sx6kIvK48EhLSMhRWNXJKyGa3k+YCfAnCxm/Meubpre9yOpTva2i
 3c/R7ds0V2H5m9cKLiB8dJ+Cq9QPkPsGcfWWB9HoY4afK0+SVMCJ1FcfulMxVWe7z9iaZ0qU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284940>

Hi Junio,

On Wed, 27 Jan 2016, Johannes Schindelin wrote:

> --8323329-1704809497-1453911609=:2964
> Content-Type: text/plain; charset=X-UNKNOWN

Oh well. I guess I am really too stupid to get this right... Will change
my script to call format-patch with the --add-header='Content-Type:
text/plain; charset=UTF-8' option to prevent more misery in the future.

Sorry,
Dscho
